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
    func getPhoto(competition: @escaping (Data) -> Void) throws{
        if let photo = attachment.photo{
            let config = URLSessionConfiguration.default
            config.waitsForConnectivity = true
            config.timeoutIntervalForResource = 10
            guard let url = URL(string: photo.photo604) else {
                throw PostViewErrors.invalidLink
            }
            URLSession(configuration: config).dataTask(with: url) { data, response, error in
                if let data = data{
                    competition(data)
                }
            }.resume()
        }
        
        throw PostViewErrors.cantConvertAttachment
    }
    func getResizedHeight() -> CGFloat{
        switch attachment.type{
        
        case .photo:
            return resizeImage(photo: attachment.photo!)
            
        case .video:
            break
        case .link:
            break
        }
        return CGFloat(1488.0)
    }
    private func resizeImage(photo: Photo) -> CGFloat{
        let scale = UIScreen.main.scale
        let width = CGFloat(photo.width) / scale
        let height = CGFloat(photo.height) / scale
        let photoSize = CGSize(width: width, height: height)
        let imageHeight = AVMakeRect(aspectRatio: photoSize, insideRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat.infinity)).height
        return imageHeight
    }
    required init?(coder: NSCoder) {
        fatalError("Do not use that or i kill u!")
    }
}
