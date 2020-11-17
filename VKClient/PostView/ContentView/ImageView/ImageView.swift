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
                    constraint.constant = AVMakeRect(aspectRatio: self.imageView.image!.size, insideRect: CGRect(x: 0, y: 0, width: superview!.frame.size.width, height: CGFloat.infinity)).height
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
    
    }
    override func didMoveToSuperview() {
        let imageHeight = AVMakeRect(aspectRatio: self.imageView.image!.size, insideRect: CGRect(x: 0, y: 0, width: superview!.frame.size.width, height: CGFloat.infinity)).height
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: topAnchor),
                                     imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     imageView.heightAnchor.constraint(equalToConstant: imageHeight),
        ])
        layoutSubviews()
        loadMedia()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadMedia() {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 60
        URLSession(configuration: config).dataTask(with: urlMedia) { [weak self] data, response, error in
            guard let self = self else{
                return
            }
            if let data = data{
                
                DispatchQueue.main.async {
                    UIView.transition(with: self.imageView,
                                      duration: 0.3,
                                      options: [.curveEaseOut, .transitionCrossDissolve],
                                      animations: {
                                            self.image = UIImage(data: data)!
                                            self.superview?.superview?.layoutIfNeeded()
                                      })
                }
            }
            if let error = error {
                print(error.localizedDescription)
            }

            
        }.resume()
    
    }
    
}
