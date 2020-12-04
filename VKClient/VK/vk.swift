//
//  vk.swift
//  VKClient
//
//  Created by Alexey on 19.11.2020.
//

import Foundation
// https://oauth.vk.com/authorize?client_id=7668689&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=friends,wall,user&response_type=token&v=5.52
class VK{
    static let api = Api(accessToken: "41f116a1758f503db4d6c432ee3d4b79044b751330fe86d0eb0090f0cbfb5a181fe246ddabdd8cc7f46f1")
    private let expiresIn = 86400
    private let user_id = 624572081
}

