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
    var picture: Picture
    func loadMedia(){
        fatalError("LoadMedia must override!")
    }
//    init(attachment: Attachment){
//        self.picture = attachment
//        super.init(frame: .zero)
//        isUserInteractionEnabled = true
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.didPressOnView(_:)))
//        addGestureRecognizer(gesture)
//
//    }
    init(media: Picture){
        self.picture = media
        super.init(frame: .zero)
        isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.didPressOnView(_:)))
        addGestureRecognizer(gesture)
    }
    @objc func didPressOnView(_ sender: UITapGestureRecognizer? = nil){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "mediaViewDidPress"), object: nil, userInfo: ["attachment": picture])
    }
    func getPhoto( needsPrePhoto: Bool = false, competition: @escaping (Data) -> Void) throws{
        let content = picture
        
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
    }
    func getResizedHeight() -> CGFloat{
        resizeImage(image: picture)
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
