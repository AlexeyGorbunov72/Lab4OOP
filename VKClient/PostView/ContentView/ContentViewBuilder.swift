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
            imageView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(imageView)
            
        }
        if let video = media as? Video{
            let videoView = VideoView(media: video, frame: rect)
            videoView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(videoView)
        }
    }
    func getContentView() -> ContentView {
        var maxHeight: CGFloat = 0
        
        contentView.subviews.forEach {
            maxHeight = max($0.frame.maxY, maxHeight)
        }
        
        contentView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: maxHeight)
        return contentView
    }
}
