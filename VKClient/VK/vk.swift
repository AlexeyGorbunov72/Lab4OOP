//
//  vk.swift
//  VKClient
//
//  Created by Alexey on 19.11.2020.
//

import Foundation
//https://oauth.vk.com/blank.html#access_token=24898a25cd0cc6e6956726de33935d889dcef0ecc25d89a09787f662c59018297dff3037b5973f8a84e84&expires_in=86400&user_id=624572081

class VK{
    static let api = Api(accessToken: "d1c7a4314bc27e24352b46c04555c76abd88efb930e1a7c997f86c20de1366f17bc959a801f9a16823bff")
    private let expiresIn = 86400
    private let user_id = 624572081
}

