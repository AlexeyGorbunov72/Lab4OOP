//
//  PostView.swift
//  VKClient
//
//  Created by Alexey on 17.11.2020.
//

import UIKit

class PostView: UIView {
    var postView: UIView?
    var post: Post
    @IBOutlet weak var likeButton: UIButton!
    var callBack: ((UITextView) -> ())?
    @IBOutlet weak var profileImage: UIImageView! {
        didSet{
            self.profileImage.layer.cornerRadius = self.profileImage.bounds.size.height / 2
            if #available(iOS 13.0, *) {
                self.profileImage.layer.borderColor = UIColor.systemGray6.cgColor
            } else {
                self.profileImage.layer.borderColor = UIColor.lightGray.cgColor
            }
            self.profileImage.layer.borderWidth = 2
        }
    }
    @IBOutlet weak var posterName: UILabel!
    @IBOutlet weak var text: SlidableTextView!
    @IBOutlet weak var timeLabel: UILabel!
    required init(post: Post){
        self.post = post
        super.init(frame: .zero)
        getView(post: post)
        setupOutlets(post: post)
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported init")
    }
    /*
     remove that to LikeButton
     */
    var liked: Bool = false
    func isLiked(){
        if liked{
            if #available(iOS 13.0, *) {
                likeButton.setImage(UIImage(systemName: "heart.fill")!.withTintColor(.systemPink), for: .normal)
            } else {
                // Fallback on earlier versions
            }
        } else {
            if #available(iOS 13.0, *) {
                likeButton.setImage(UIImage(systemName: "heart")!.withTintColor(.systemPink), for: .normal)
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
    private func setupOutlets(post: Post){
        text.callBack = callBack
        if let postText = post.text{
            let trimed = postText.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            if !trimed.isEmpty{
                text.setText(text: trimed)
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
        setupContentView(attachments: post.attachments!)
        layoutSubviews()
    }
    func setupContentView(attachments: [Attachment]){
        
        for view in postView!.subviews{
            if let view = view as? ContentView{
                //view.addMedia(attachment: attachments[0])
                let manager = MediaDirector(widthPlaceholder: UIScreen.main.bounds.width, heightPlaceholder: UIScreen.main.bounds.height, attachments: attachments)

                let contentView = manager.build()
                
                view.addSubview(contentView)
                
                
                NSLayoutConstraint.activate([
                    contentView.topAnchor.constraint(equalTo: view.topAnchor),
                    contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                ])
                 
            }
        }
    }

    @IBAction func didPressLike(_ sender: Any) {
        let likeCommand = LikeCommand(likable: post)
        likeCommand.execute()
        liked = !liked
        isLiked()
    }
    
    @IBAction func didPressComment(_ sender: Any) {
    }
}
