//
//  TestViewController.swift
//  VKClient
//
//  Created by Alexey on 25.11.2020.
//

import UIKit

class TestViewController: UIViewController {
    
    var pizda = UIView()
    var posts: [Post] = []
    var counter = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        pizda.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pizda)
        pizda.isUserInteractionEnabled = true
        pizda.backgroundColor = .blue
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.didTap(_:)))
        pizda.addGestureRecognizer(gesture)
        NSLayoutConstraint.activate([
            pizda.topAnchor.constraint(equalTo: view.topAnchor),
            pizda.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pizda.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pizda.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        VK.api.getFeed() { response in
            self.posts = response.items
        }
        view.layoutSubviews()
    }
    @objc func didTap(_ sender: UITapGestureRecognizer? = nil){
        counter += 1
        DispatchQueue.main.async { [self] in
            if pizda.subviews.count > 0{
                pizda.subviews[0].removeFromSuperview()
            }
            
            let manager = MediaDirector(widthPlaceholder: UIScreen.main.bounds.width, heightPlaceholder: UIScreen.main.bounds.height, attachments: posts[counter].attachments!)

            let contentView = manager.build()

            pizda.addSubview(contentView)
            contentView.layer.borderColor = UIColor.black.cgColor
            contentView.layer.borderWidth = 3
            print(contentView.frame)
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
