//
//  FeedTableViewCell.swift
//  VKClient
//
//  Created by Alexey on 19.11.2020.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    var feedPostView: PostView?
    var callBack: ((UITextView) -> ())?{
        didSet{
            
            feedPostView!.text.callBack = callBack
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func addPostView(post: Post?){
        if feedPostView != nil{
            feedPostView!.removeFromSuperview()
        }
        if let post = post{
            feedPostView = PostView(post: post)
            guard let feedPostView = feedPostView else {
                return
            }
            
            feedPostView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(feedPostView)
            NSLayoutConstraint.activate([
                feedPostView.topAnchor.constraint(equalTo: topAnchor),
                feedPostView.leadingAnchor.constraint(equalTo: leadingAnchor),
                feedPostView.trailingAnchor.constraint(equalTo: trailingAnchor),
                feedPostView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
        }
        
    }
}
