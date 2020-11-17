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
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        getView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        getView()
    }
    private func getView(){
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
    }

}
