//
//  ContentView.swift
//  VKClient
//
//  Created by Alexey on 17.11.2020.
//

import UIKit

class ContentView: UIView {


    func addMedia(attachment: Attachment){
        addPicMedia(attachment: attachment)
    }
    private func addPicMedia(attachment: Attachment){
        let imageView = attachment.getImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: topAnchor),
                                     imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     imageView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}
