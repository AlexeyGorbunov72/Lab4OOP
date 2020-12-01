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
    var imageView: UIImageView = UIImageView()
    
    init(attachment: Attachment) {
        super.init(media: attachment.content)
        setup()
    }
    override init(media: Picture){
        super.init(media: media)
        setup()
    }
    init(media: Picture, frame: CGRect){
        super.init(media: media)
        self.frame = frame
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size)
        
        addSubview(imageView)
        setUpMedia()
    }
    private func setup(){
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
        print("image:", imageView.frame)
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

