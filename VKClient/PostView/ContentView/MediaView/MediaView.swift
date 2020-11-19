//
//  MediaView.swift
//  VKClient
//
//  Created by Alexey on 17.11.2020.
//

import Foundation
import UIKit
import AVFoundation
class MediaView: UIView{
    var attachment: Attachment
    func loadMedia(){
        fatalError("LoadMedia must override!")
    }
    init(attachment: Attachment){
        self.attachment = attachment
        super.init(frame: .zero)
        
    }
    func getPhoto( needsPrePhoto: Bool = false, competition: @escaping (Data) -> Void) throws{
        var content: Picture?
        if let pic = attachment.photo{
            content = pic
        }
        if let video = attachment.video{
            content = video
        }
        if let content = content{
            let config = URLSessionConfiguration.default
            config.waitsForConnectivity = true
            config.timeoutIntervalForResource = 10
            var stringUrl = content.photo
            if needsPrePhoto{
                stringUrl = content.prePhoto
            }
            guard let url = URL(string: stringUrl) else {
                throw PostViewErrors.invalidLink
            }
            URLSession(configuration: config).dataTask(with: url) { data, response, error in
                if let data = data{
                    competition(data)
                }
            }.resume()
        } else {
            throw PostViewErrors.cantConvertAttachment
        }
        
        
    }
    func getResizedHeight() -> CGFloat{
        switch attachment.type{
        
        case .photo:
            return resizeImage(image: attachment.photo!)
            
        case .video:
            4
            return resizeImage(image: attachment.video!)
        case .link:
            break
        }
        return CGFloat(1488.0)
    }
    private func resizeImage(image: Picture) -> CGFloat{
        let scale = UIScreen.main.scale
        let width = CGFloat(image.width) / scale
        let height = CGFloat(image.height) / scale
        let photoSize = CGSize(width: width, height: height)
        let imageHeight = AVMakeRect(aspectRatio: photoSize, insideRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat.infinity)).height
        return imageHeight
    }
    required init?(coder: NSCoder) {
        fatalError("Do not use that or i kill u!")
    }
}
