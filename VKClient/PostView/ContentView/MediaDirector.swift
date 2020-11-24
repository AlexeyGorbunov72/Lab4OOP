//
//  ContentViewBuilder.swift
//  VKClient
//
//  Created by Alexey on 24.11.2020.
//

import Foundation
import UIKit

class MediaDirector{
    private var attachments: [Attachment]
    private lazy var arrayRatioSize: [CGSize] = {
        var array: [CGSize] = []
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
        fillArrayRatioSize()
    }
    private func sortAttachmentsByHeight(){
        attachments.sort { $0.content.height > $1.content.height }
    }
    
    // return new aspect height
    private func aspectRatio(content: Picture, width: CGFloat) -> CGFloat{
        let ratio = CGFloat(content.width) / width
        return CGFloat(content.height) / ratio
    }
    private func fillArrayRatioSize(){
        let leftRange = 0..<(attachments.count / 2)
        let rightRange = (attachments.count / 2)..<attachments.count
        normalize(in: leftRange)
        normalize(in: rightRange)
    }
    
    // this for normalize left and right halfs
    private func normalize(in range: Range<Int>){
        var totalHeight: CGFloat = LayoutResurses.verticalSeparator * CGFloat(attachments.count / 2 - 1)
        for i in range{
            let newWidth = width / 2 - LayoutResurses.horizontalSeparator / 2
            let newHeight = aspectRatio(content: attachments[i].content, width: newWidth)
            arrayRatioSize[i] = CGSize(width: newWidth, height: newHeight)
            totalHeight += arrayRatioSize[i].height
        }
        
        if totalHeight > height{
            let ratio = height / totalHeight
            for i in range{
                arrayRatioSize[i].height *= ratio
                arrayRatioSize[i].width *= ratio
            }
        }
    }
    
}

struct LayoutResurses{
    static let verticalSeparator: CGFloat = 10
    static let horizontalSeparator: CGFloat = 10
}
