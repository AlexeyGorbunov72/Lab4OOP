//
//  VideoView.swift
//  VKClient
//
//  Created by Alexey on 19.11.2020.
//

import UIKit
import AVKit
class VideoView: ImageView {
    
    
    let concentrate = VideoViewConcentrate()
    let playButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "play.circle")
        imageView.tintColor = .gray
        imageView.alpha = 0.7
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    override init(attachment: Attachment) {
        super.init(attachment: attachment)
        
        let fuck = UIView()
        
        fuck.translatesAutoresizingMaskIntoConstraints = false
        fuck.contentMode = .scaleAspectFit
        //fuck.clipsToBounds = true
        
        let myImage = UIImage(systemName: "play.circle")?.cgImage
        fuck.layer.contents = myImage
        fuck.isUserInteractionEnabled = true
        addSubview(fuck)

        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.buttonDidPress(_:)))
        fuck.addGestureRecognizer(gesture)
        NSLayoutConstraint.activate([
            fuck.centerXAnchor.constraint(equalTo: centerXAnchor),
            fuck.centerYAnchor.constraint(equalTo: centerYAnchor),
            fuck.heightAnchor.constraint(equalToConstant: 50),
            fuck.widthAnchor.constraint(equalToConstant: 50),
        ])
        
        
        
    }
    @objc func buttonDidPress(_ sender: UITapGestureRecognizer? = nil){
        //let player = AVPlayer(url: "")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
