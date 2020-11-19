//
//  ContentView.swift
//  VKClient
//
//  Created by Alexey on 17.11.2020.
//

import UIKit

class ContentView: UIView {


    func addMedia(attachment: Attachment){
        switch attachment.type {
        case .photo:
            addPicMedia(attachment: attachment)
            break
            
        case .video: break
            
        case .link:
            break
        }
    }
    private func addPicMedia(attachment: Attachment){
        let imageView = ImageView(attachment: attachment)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: topAnchor),
                                     imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     imageView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}
