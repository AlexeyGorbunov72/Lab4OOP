//
//  vk.swift
//  VKClient
//
//  Created by Alexey on 19.11.2020.
//

import Foundation
// https://oauth.vk.com/authorize?client_id=7668689&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=friends,wall&response_type=token&v=5.52
class VK{
    static let api = Api(accessToken: "5a585866185a7aaea3c56a5373a51812d355ad703b25fba4e5c65dd094942087a0ad6c92966667dd463f8")
    private let expiresIn = 86400
    private let user_id = 624572081
}

