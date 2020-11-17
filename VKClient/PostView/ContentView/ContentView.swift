//
//  ContentView.swift
//  VKClient
//
//  Created by Alexey on 17.11.2020.
//

import UIKit

class ContentView: UIView {

    override func awakeFromNib() {
        let imageView = ImageView(frame: bounds, urlMedia: "https://sun9-36.userapi.com/3B4fup_5gngeLPZBrlLCX6NgvAalIBuAlF0q-w/rZNfVmj1MOA.jpg")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: topAnchor),
                                     imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     imageView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }

}
