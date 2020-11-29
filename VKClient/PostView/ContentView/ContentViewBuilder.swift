//
//  ContentViewBuilder.swift
//  VKClient
//
//  Created by Alexey on 24.11.2020.
//

import Foundation
import UIKit
class ContentViewBuilder{
    private var contentView = ContentView()
    func buildMediaItem(in rect: CGRect, media: Picture){
        // TODO: add logic
        if let image = media as? Photo{
            let imageView = ImageView(media: image, frame: rect)
            imageView.frame = rect
            contentView.addSubview(imageView)
        }
        if let video = media as? Video{
            let videoView = VideoView(media: video)
            videoView.frame = rect
            contentView.addSubview(videoView)
        }
    }
    func getContentView() -> ContentView {
        var maxHeight: CGFloat = 0
        contentView.subviews.forEach {
            maxHeight = max($0.frame.maxY, maxHeight)
        }
        contentView.heightAnchor.constraint(equalToConstant: maxHeight).isActive = true
        return contentView
    }
}
