//
//  Api.swift
//  VKClient
//
//  Created by Alexey on 19.11.2020.
//

import Foundation
class Api{
    static private var nextFrom: String?
    static private let accessToken = "24898a25cd0cc6e6956726de33935d889dcef0ecc25d89a09787f662c59018297dff3037b5973f8a84e84"
    
    static func getFeed(count: Int = 50, completion: @escaping (Response) -> Void){
        var url: URL?
        if let nextForm = nextFrom{
            url = URL(string: "https://api.vk.com/method/newsfeed.get?count=\(count)&start_from=\(nextFrom)&v=5.52&access_token=\(Api.accessToken)")
        } else{
            url = URL(string: "https://api.vk.com/method/newsfeed.get?count=\(count)&v=5.52&access_token=\(Api.accessToken)")
        }
        guard let unwarpedUrl = url else{
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: unwarpedUrl){ data, response, error in
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            jsonDecoder.dateDecodingStrategy = .secondsSince1970
            if let data = data{
                let model = try! jsonDecoder.decode(Model.self, from: data)
                nextFrom = model.response.nextFrom
                completion(model.response)
            }
        }
        task.resume()
    }
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
}
struct Photo: Codable{
    var height: Int
    var width: Int
    var photo604: String
}
struct Groups: Codable{
    var group: [Group]
}
struct Group: Codable{
    var id: Int
    var name: String
    var photo50: String
}

enum ContentType: String, Codable{
    case photo
    case video
    case link
}
