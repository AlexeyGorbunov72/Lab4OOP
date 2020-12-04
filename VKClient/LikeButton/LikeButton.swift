//
//  LikeButton.swift
//  VKClient
//
//  Created by Alexey on 04.12.2020.
//

import UIKit


class LikeButton: UIImageView{
    var likeCommand: LikeCommand?
    var isLiked = false
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        contentMode = .scaleAspectFit
        if #available(iOS 13.0, *) {
            image = UIImage(systemName: "heart")!.withTintColor(.systemPink)
        }
        addGestureRecognizer(tapGesture)
    }
    func pushContent(likable: Likable){
        likeCommand = LikeCommand(likable: likable)
    }
    private func isLiked_() -> Bool{
        return isLiked
    }
    @objc private func didTap(_ sender: UITapGestureRecognizer){
        if isLiked_(){
            if #available(iOS 13.0, *) {
                image = UIImage(systemName: "heart")!.withTintColor(.systemPink)
            }
        } else {
            if #available(iOS 13.0, *) {
                image = UIImage(systemName: "heart.fill")!.withTintColor(.systemPink)
            }
        }
        guard let likeCommand = likeCommand else {
            return
        }
        likeCommand.execute()
    }
}
