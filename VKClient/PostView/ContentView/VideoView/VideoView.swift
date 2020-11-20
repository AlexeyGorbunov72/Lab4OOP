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
        let playButton = UIView()
                
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.contentMode = .scaleAspectFit
               
                
        let myImage = UIImage(systemName: "play.circle")?.cgImage
        playButton.layer.contents = myImage
        playButton.isUserInteractionEnabled = true
        addSubview(playButton)

        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.buttonDidPress(_:)))
        playButton.addGestureRecognizer(gesture)
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 50),
            playButton.widthAnchor.constraint(equalToConstant: 50),
        ])
        
    }
    @objc func buttonDidPress(_ sender: UITapGestureRecognizer? = nil){
        
        VK.api.getVideoUrlByOvnerId(ownerId: attachment.video!.ownerId){  stringUrlToVideo in
            DispatchQueue.main.async {
                let videoURL = URL(string: stringUrlToVideo)
                UIApplication.shared.open(videoURL!)
            }
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
