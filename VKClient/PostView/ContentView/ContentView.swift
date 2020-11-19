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
            
        case .video:
            addPicMedia(attachment: attachment)
            break
            
        case .link:
            break
        }
    }
    private func addPicMedia(attachment: Attachment){
        var imageView: ImageView?
        if attachment.type == .photo{
            imageView = ImageView(attachment: attachment)
        }
        if attachment.type == .video{
            imageView = VideoView(attachment: attachment)
        }
        guard let unwarpedImageView = imageView else {
            return
        }
        unwarpedImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(unwarpedImageView)
        NSLayoutConstraint.activate([unwarpedImageView.topAnchor.constraint(equalTo: topAnchor),
                                     unwarpedImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     unwarpedImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     unwarpedImageView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}
