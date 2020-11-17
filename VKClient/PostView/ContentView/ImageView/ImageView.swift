//
//  ImageView.swift
//  VKClient
//
//  Created by Alexey on 17.11.2020.
//
import AVFoundation
import UIKit
class ImageView: MediaView {
    var image: UIImage {
        set(newImage){
            imageView.image = newImage
            for constraint in imageView.constraints{
                if constraint.firstAttribute == .height{
                    constraint.constant = AVMakeRect(aspectRatio: self.imageView.image!.size, insideRect: self.superview!.frame).height
                    print(AVMakeRect(aspectRatio: self.imageView.image!.size, insideRect: self.superview!.frame).height)
                }
            }
        }
        get{
            return imageView.image!
        }
    }
    var imageView: UIImageView
    
    override init(frame: CGRect, urlMedia: String) {
        imageView = UIImageView()
        super.init(frame: frame, urlMedia: urlMedia)
        image = UIImage(named: "loading")!
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        clipsToBounds = true
        addSubview(imageView)
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: topAnchor),
                                     imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     imageView.heightAnchor.constraint(equalToConstant: 500),
        ])
        loadMedia()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadMedia() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {
                return
            }
            let data = try? Data(contentsOf: self.urlMedia)
            DispatchQueue.main.async {
                
                UIView.transition(with: self.imageView,
                                  duration: 0.3,
                                                options: [.curveEaseOut, .transitionCrossDissolve],
                                                animations: {
                                                    self.image = UIImage(data: data!)!
                                                    self.superview!.superview!.layoutIfNeeded()
                                                })
            }
        }
    }
    
}
