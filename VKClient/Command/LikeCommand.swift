//
//  LikeCommand.swift
//  VKClient
//
//  Created by Alexey on 02.12.2020.
//

import Foundation

protocol Likable {
    var ownerId: Int64 { get set }
    var itemId: Int64 { get set }
    var contentType: ContentType { get set }
}

class LikeCommand: Command{
    var likable: Likable
    let vkLikeApi = VK.api as VKApiLikes
    required init(likable: Likable) {
        self.likable = likable
        super.init()
    }
    override func undo() {
    
        undoLike()
    }
    
    override func execute() {
        vkLikeApi.isLiked(toCheck: self.likable){ isLiked in
            isLiked ? self.undo() : self.setLike()
        }
    }
    
    private func undoLike() {
        // TODO: add vk api logic
        vkLikeApi.undoLike(toUndo: likable)

    }
    private func setLike(){
        // TODO: add vk api logic
        vkLikeApi.setLike(toLike: likable)
    }
}
