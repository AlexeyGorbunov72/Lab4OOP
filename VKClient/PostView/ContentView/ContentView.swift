//
//  ContentView.swift
//  VKClient
//
//  Created by Alexey on 17.11.2020.
//

import UIKit

class ContentView: UIView {


    func addMedia(url: String, type: TypesMedia){
        switch type {
        case .pic:
            addPicMedia(url: url)
            break
            
        case .video: break
            
        }
    }
    private func addPicMedia(url: String){
        let imageView = ImageView(frame: bounds, urlMedia: url)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: topAnchor),
                                     imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     imageView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}
