//
//  ImageView.swift
//  VKClient
//
//  Created by Alexey on 17.11.2020.
//
import AVFoundation
import UIKit
class ImageView: MediaView {
    var image: UIImage? {
        set(newImage){
            imageView.image = newImage
        }
        get{
            return imageView.image
        }
    }
    var imageView: UIImageView
    
    override init(attachment: Attachment) {
        
        imageView = UIImageView()
        super.init(attachment: attachment)
        translatesAutoresizingMaskIntoConstraints = false
        try? getPhoto(needsPrePhoto: true){ [weak self] picData in
            guard let self = self else{
                return
            }
            DispatchQueue.main.async {
                if self.image == nil{
                    self.image = UIImage(data: picData)!
                }
                
            }
        }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        let imageHeight = getResizedHeight()
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: topAnchor),
                                     imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     imageView.heightAnchor.constraint(equalToConstant: imageHeight),
        ])
        
        setUpMedia()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpMedia() {
        try? getPhoto(){ [weak self] picData in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                UIView.transition(with: self.imageView,
                                  duration: 0.3,
                                  options: [.curveEaseOut, .transitionCrossDissolve],
                                  animations: {
                                    self.image = UIImage(data: picData)!
                                  })
            }
        }
    }
    
}

