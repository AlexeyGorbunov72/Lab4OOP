//
//  ContentViewBuilder.swift
//  VKClient
//
//  Created by Alexey on 24.11.2020.
//

import Foundation
import UIKit

class MediaDirector{
    private var builder = ContentViewBuilder()
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
    func build(){
        sortAttachmentsByHeight()
        fillArrayRatioRect()
        for (i, rect) in arrayRatioRect.enumerated(){
            builder.buildMediaItem(in: rect, media: attachments[i].content)
        }
    }
    private func sortAttachmentsByHeight(){
        attachments.sort { $0.content.height > $1.content.height }
    }
    
    // return new aspect height
    private func aspectRatio(content: Picture, width: CGFloat) -> CGFloat{
        let ratio = CGFloat(content.width) / width
        return (CGFloat(content.height)) / ratio // TODO: UIScreen ... convert size to Screen resolution
    }
    private func fillArrayRatioRect(){
        let leftRange = 0..<(attachments.count / 2)
        let rightRange = (attachments.count / 2)..<attachments.count
        normalize(in: leftRange, horizontalOffset: 0)
        normalize(in: rightRange, horizontalOffset: width / 2)
        
    }
    
    // this for normalize left and right halfs
    private func normalize(in range: Range<Int>, horizontalOffset: CGFloat){
        var totalHeight: CGFloat = LayoutResurses.verticalSeparator * CGFloat(attachments.count / 2 - 1)
        var counterOfHeight: CGFloat = 0
        for i in range{
            let newWidth = width / 2 - LayoutResurses.horizontalSeparator / 2
            let newHeight = aspectRatio(content: attachments[i].content, width: newWidth)
            arrayRatioRect[i] = CGRect(x: horizontalOffset, y: counterOfHeight, width: newWidth, height: newHeight)
            totalHeight += arrayRatioRect[i].height
            counterOfHeight += newHeight + LayoutResurses.horizontalSeparator
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
