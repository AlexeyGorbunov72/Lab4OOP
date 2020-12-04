//
//  VKApiLikeProtocol.swift
//  VKClient
//
//  Created by Alexey on 03.12.2020.
//

protocol VKApiLikes {
    func setLike(toLike: Likable)
    func undoLike(toUndo: Likable)
    func isLiked(toCheck: Likable, response: @escaping(Bool) -> Void)
}
