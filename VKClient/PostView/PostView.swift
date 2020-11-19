//
//  PostView.swift
//  VKClient
//
//  Created by Alexey on 17.11.2020.
//

import UIKit

class PostView: UIView {
    var postView: UIView?
//    var post: Post?{
//        didSet{
//            setupContentView(urlToMedia: post?.attachments?[0].photo?.photo604)
//        }
//    }
    @IBOutlet weak var profileImage: UIImageView! {
        didSet{
            self.profileImage.layer.cornerRadius = self.profileImage.bounds.size.height / 2
        }
    }
    required init(post: Post){
        super.init(frame: .zero)
        getView(post: post)
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported init")
//        super.init(coder: coder)
//        getView()
    }
    private func getView(post: Post){
        let viewFromNib = UINib(nibName: "PostView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as? UIView
        postView = viewFromNib!.subviews[0]
        guard let postView = postView else {
            return
        }
        
        postView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(postView)
        NSLayoutConstraint.activate([
            postView.topAnchor.constraint(equalTo: topAnchor),
            postView.bottomAnchor.constraint(equalTo: bottomAnchor),
            postView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        setupContentView(attachment: post.attachments?[0])
        layoutSubviews()
    }
    func setupContentView(attachment: Attachment?){
        guard let attachment = attachment else {
            return
        }
        for view in postView!.subviews{
            if let view = view as? ContentView{
                
                view.addMedia(attachment: attachment)
            }
        }
    }

}
