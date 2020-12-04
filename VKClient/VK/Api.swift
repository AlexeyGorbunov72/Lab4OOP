//
//  Api.swift
//  VKClient
//
//  Created by Alexey on 19.11.2020.
//

import Foundation
class Api{
    private var nextFrom: String?
    private var accessToken: String
    private var groupsInfo: [Group] = []
    private var bufferImages: [String : Data] = [:]
    private var wait = false
    init(accessToken: String){
        self.accessToken = accessToken
    }
    func getFeed(count: Int = 50, completion: @escaping (Response) -> Void){
        print(accessToken)
        if wait{
            return
        }
        wait = true
        var url: URL?
        if let nextForm = nextFrom{
            
            url = URL(string: "https://api.vk.com/method/newsfeed.get?filters=post&count=\(count)&start_from=" + nextForm + "&v=5.52&access_token=\(accessToken)")
        } else{
            url = URL(string: "https://api.vk.com/method/newsfeed.get?filters=post&count=\(count)&v=5.52&access_token=\(accessToken)")
        }
        guard let unwarpedUrl = url else{
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: unwarpedUrl){ data, response, error in
            let jsonDecoder = JSONDecoder()
            self.wait = false
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            jsonDecoder.dateDecodingStrategy = .secondsSince1970
            if let data = data{
                print(String(data: data, encoding: .utf8)!)
                let model = try! jsonDecoder.decode(Model.self, from: data)
                self.nextFrom = model.response.nextFrom
                self.groupsInfo += model.response.groups
                
                completion(model.response)
            }
        }
        task.resume()
        
    }
    func getPosterImage(groupId: Int64, competition: @escaping (Data) -> Void) throws{
        for group in groupsInfo{
            if group.id + groupId == 0{
                let config = URLSessionConfiguration.default
                config.waitsForConnectivity = true
                config.timeoutIntervalForResource = 10
                guard let url = URL(string: group.photo50) else {
                    throw PostViewErrors.invalidLink
                }
                if let data = bufferImages[url.absoluteString]{
                    competition(data)
                    return
                }
                URLSession(configuration: config).dataTask(with: url) { data, response, error in
                    if let data = data{
                        self.bufferImages[url.absoluteString] = data
                        competition(data)
                    }
                }.resume()
            }
        }

    }
    func getPosterName(groupId: Int64) -> String{
        for group in groupsInfo{
            if group.id + groupId == 0{
                return group.name
            }
        }
        return "?"
    }
    func getVideoUrlByOvnerId(ownerId: Int64, completion: @escaping (String) -> Void){
        let url = URL(string: "https://api.vk.com/method/video.get?owner_id=\(ownerId)&count=1&v=5.52&access_token=\(accessToken)")
        let session = URLSession.shared
        if let unwarpedUrl = url{
            let task = session.dataTask(with: unwarpedUrl){ data, response, error in
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            if let data = data{
                print(String(data: data, encoding: .utf8)!)
                let model = try! jsonDecoder.decode(ModelVideo.self, from: data)
                completion(model.response.items[0].player)
            }
        }
            task.resume()
        }
        
    }
    private func _setLike(likable: Likable){
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 10
        guard let url = URL(string: "https://api.vk.com/method/likes.add?type=\(likable.contentType)&owner_id=\(likable.ownerId)&item_id=\(likable.itemId)" + "&v=5.52&access_token=\(accessToken)") else {
            return
        }
        URLSession(configuration: config).dataTask(with: url) { data, response, _ in
            if let data = data{
                // nice
            }
        }.resume()
    }
    private func _undoLike(likable: Likable){
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 10
        guard let url = URL(string: "https://api.vk.com/method/likes.add?type=\(likable.contentType)&owner_id=\(likable.ownerId)&item_id=\(likable.itemId)" + "&v=5.52&access_token=\(accessToken)") else {
            return
        }
        URLSession(configuration: config).dataTask(with: url) { data, response, _ in
            if let data = data{
                // nice
            }
        }.resume()
    }
    private func _isLike(likable: Likable, response: @escaping(Bool) -> Void){
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 10
        guard let url = URL(string: "https://api.vk.com/method/likes.isliked?type=\(likable.contentType)&owner_id=\(likable.ownerId)&item_id=\(likable.itemId)" + "&v=5.52&access_token=\(accessToken)") else {
            return
        }
        URLSession(configuration: config).dataTask(with: url) { data, _, error in
            if let data = data{
                self.bufferImages[url.absoluteString] = data
                print(String(data: data, encoding: .utf8))
                var _responseRaw = 1
                response( _responseRaw == 1 )
            }
        }.resume()
    }
}

extension Api: VKApiLikes{
    func setLike(toLike: Likable){
        /*
         VK API выдает доступ к этому методу
         только проверенным приложениям :(
        */
        _setLike(likable: toLike)
    }
    func undoLike(toUndo: Likable){
        /*
         VK API выдает доступ к этому методу
         только проверенным приложениям :(
        */
        _undoLike(likable: toUndo)
    }
    func isLiked(toCheck: Likable, response: @escaping(Bool) -> Void){
        _isLike(likable: toCheck, response: response)
    }
    
}

struct ModelVideo: Codable{
    var response: VideoResponse
}
struct VideoResponse: Codable {
    var items: [Item]
}
struct Item: Codable{
    var player: String
}
struct Model: Codable{
    var response: Response
}
struct Response: Codable {
    var items: [Post]
    var groups: [Group]
    var nextFrom: String
}
struct Post: Codable, Likable{
    var ownerId: Int64 = 0
    
    var contentType: ContentType = .photo
    
    var sourceId: Int64
    
    var itemId: Int64
    var date: Date
    var text: String?
    //var contentType: ContentType = .post
    var attachments: [Attachment]?
    enum CodingKeys: String, CodingKey {
        // case contentType = "type"
        case sourceId = "sourceId"
       // case ownerId = "sourceId"
        case itemId = "postId"
        case date
        case text
        case attachments
    }
}
struct Attachment: Codable{
    var contentType: ContentType
    var photo: Photo?
    var video: Video?
    var content: Picture {
        get{
            if let photo = photo{
                return photo
            }
            if let video = video{
                return video
            }
            fatalError("1488 228")
        }
        set{
            
        }
    }
    
    func getImageView() -> ImageView{
        if photo != nil{
            return ImageView(media: content)
        } else {
            return VideoView(media: content)
        }
        
    }
    enum CodingKeys: String, CodingKey {
        case contentType = "type"
        case photo
        case video
        
    }
}
struct Photo: Codable, Picture, Likable{
    var ownerId: Int64
    var itemId: Int64
    var contentType: ContentType = .photo
    
    var height: Int
    var width: Int
    var photo: String
    var prePhoto: String
    enum CodingKeys: String, CodingKey {
        case photo = "photo604"
        case prePhoto = "photo75"
        case height
        case width
        case itemId = "id"
        case ownerId
        
        
    }
}
struct Video: Codable, Picture, Likable{
    var ownerId: Int64
    var itemId: Int64
    var contentType: ContentType = .video
    var height: Int
    var width: Int
    var photo: String
    var duration: Int
    var title: String
    var views: Int
    var prePhoto: String
    enum CodingKeys: String, CodingKey {
        case photo = "firstFrame1280"
        case prePhoto = "firstFrame130"
        case height
        case width
        case duration
        case title
        case views
        case ownerId
        case itemId = "id"
        
    }
    
}
struct Groups: Codable{
    var group: [Group]
}
struct Group: Codable{
    var id: Int64
    var name: String
    var photo50: String
}
protocol Picture {
    var height: Int { get set }
    var width: Int { get set }
    var photo: String { get set }
    var prePhoto: String { get set }
}
enum ContentType: String, Codable{
    case photo = "photo"
    case video = "video"
    case post = "post"
}
