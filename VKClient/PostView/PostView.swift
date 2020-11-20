//
//  PostView.swift
//  VKClient
//
//  Created by Alexey on 17.11.2020.
//

import UIKit

class PostView: UIView {
    var postView: UIView?
    @IBOutlet weak var profileImage: UIImageView! {
        didSet{
            self.profileImage.layer.cornerRadius = self.profileImage.bounds.size.height / 2
            self.profileImage.layer.borderColor = UIColor.systemGray6.cgColor
            self.profileImage.layer.borderWidth = 2
        }
    }
    @IBOutlet weak var posterName: UILabel!
    @IBOutlet weak var text: UITextView!
    required init(post: Post){
        super.init(frame: .zero)
        getView(post: post)
        setupOutlets(post: post)
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported init")
    }
    private func setupOutlets(post: Post){
        if let postText = post.text{
            let trimed = postText.trimmingCharacters(in: .whitespacesAndNewlines)
            if !trimed.isEmpty{
                text.text = trimed
            }
        }
        
        posterName.text = VK.api.getPosterName(groupId: post.sourceId)
        try? VK.api.getPosterImage(groupId: post.sourceId){ [weak self] data in
            guard let self = self else{
                return
            }
            DispatchQueue.main.async {
                self.profileImage.image = UIImage(data: data)
            }
            
        }
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
