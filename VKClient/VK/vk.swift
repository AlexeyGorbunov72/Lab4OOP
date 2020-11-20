//
//  vk.swift
//  VKClient
//
//  Created by Alexey on 19.11.2020.
//

import Foundation
//https://oauth.vk.com/blank.html#access_token=24898a25cd0cc6e6956726de33935d889dcef0ecc25d89a09787f662c59018297dff3037b5973f8a84e84&expires_in=86400&user_id=624572081

class VK{
    static let api = Api(accessToken: "fcf7d4025d38fafd2df0359de54c072892458aaa02077b0060a5f4ffd98016b42dbbcfd181d1e0c0f7960")
    private let expiresIn = 86400
    private let user_id = 624572081
}

