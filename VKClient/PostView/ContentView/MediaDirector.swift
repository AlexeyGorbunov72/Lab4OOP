//
//  ContentViewBuilder.swift
//  VKClient
//
//  Created by Alexey on 24.11.2020.
//

import Foundation
import UIKit
import AVKit
class MediaDirector{
    
    private var attachments: [Attachment]
    private lazy var arrayRatioRect: [CGRect] = {
        var array: [CGRect] = []
        for _ in 0..<attachments.count {
            array.append(.zero)
        }
        return array
    }()
    
    private var width: CGFloat
    private var height: CGFloat
    
    init(widthPlaceholder: CGFloat, heightPlaceholder: CGFloat, attachments: [Attachment]) {
        width = widthPlaceholder
        height = heightPlaceholder
        self.attachments = attachments
    }
    func build() -> ContentView{
        let builder = ContentViewBuilder()
        sortAttachmentsByHeight()
        fillArrayRatioRect()
        
        for (i, rect) in arrayRatioRect.enumerated(){
            
            builder.buildMediaItem(in: rect, media: attachments[i].content)
        }
        return builder.getContentView()
    }
    private func sortAttachmentsByHeight(){
        attachments.sort { $0.content.height > $1.content.height }
    }
    
    // return new aspect height
    private func aspectRatio(content: Picture, width: CGFloat) -> CGSize{
        let scale = UIScreen.main.scale
        let shitSize = CGSize(width: CGFloat(content.width) / scale , height: CGFloat(content.height) / scale)
        let shit = AVMakeRect(aspectRatio: shitSize, insideRect: CGRect(x: 0, y: 0, width: width, height: CGFloat.infinity))

        return shit.size
    }
    private func fillArrayRatioRect(){
        let leftRange = 0..<(attachments.count / 2)
        let rightRange = (attachments.count / 2)..<attachments.count
        if attachments.count == 1{
            normalize(in: 0..<1, horizontalOffset: 0)
            return
        }
        normalize(in: leftRange, horizontalOffset: 0)
        normalize(in: rightRange, horizontalOffset: width / 2)
        
    }
    
    // this for normalize left and right halfs
    private func normalize(in range: Range<Int>, horizontalOffset: CGFloat){
        var totalHeight: CGFloat = LayoutResurses.verticalSeparator * CGFloat(attachments.count / 2 - 1)
        var widthOfNormalize = width / 2
        if attachments.count == 1{
            widthOfNormalize = width
        }
        var counterOfHeight: CGFloat = 0
        for i in range{
            var width_ = widthOfNormalize
            var horizontalOffset_ = horizontalOffset
            if i == attachments.count - 1 && attachments.count & 1 == 1{
                width_ = UIScreen.main.bounds.width
                horizontalOffset_ = 0
            }
            
            let sizeRect = aspectRatio(content: attachments[i].content, width: width_)
            arrayRatioRect[i] = CGRect(origin: CGPoint(x: horizontalOffset_, y: counterOfHeight), size: sizeRect)
            totalHeight += arrayRatioRect[i].height
            counterOfHeight += sizeRect.height + LayoutResurses.horizontalSeparator
        }
        
        if totalHeight > height{
            let ratio = height / totalHeight
            for i in range{
                self.arrayRatioRect[i].size.height *= ratio
                self.arrayRatioRect[i].size.width *= ratio
            }
        }
    }
    
}

struct LayoutResurses{
    static let verticalSeparator: CGFloat = 10
    static let horizontalSeparator: CGFloat = 10
}
