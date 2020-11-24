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
    func getPosterImage(groupId: Int32, competition: @escaping (Data) -> Void) throws{
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
    func getPosterName(groupId: Int32) -> String{
        for group in groupsInfo{
            if group.id + groupId == 0{
                return group.name
            }
        }
        return "?"
    }
    func getVideoUrlByOvnerId(ownerId: Int32, completion: @escaping (String) -> Void){
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
struct Post: Codable{
    var sourceId: Int32
    var date: Date
    var text: String?
    var attachments: [Attachment]?
}

struct Attachment: Codable{
    var type: ContentType
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
}
struct Photo: Codable, Picture{
    var height: Int
    var width: Int
    var photo: String
    var prePhoto: String
    enum CodingKeys: String, CodingKey {
        case photo = "photo604"
        case prePhoto = "photo75"
        case height
        case width
        
    }
}
struct Video: Codable, Picture{
    var height: Int
    var width: Int
    var photo: String
    var duration: Int
    var title: String
    var views: Int
    var prePhoto: String
    var ownerId: Int32
    enum CodingKeys: String, CodingKey {
        case photo = "firstFrame1280"
        case prePhoto = "firstFrame130"
        case height
        case width
        case duration
        case title
        case views
        case ownerId
    }
    
}
struct Groups: Codable{
    var group: [Group]
}
struct Group: Codable{
    var id: Int32
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
    case photo
    case video
}
