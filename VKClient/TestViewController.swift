//
//  TestViewController.swift
//  VKClient
//
//  Created by Alexey on 25.11.2020.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var ihatemyself: UIView!
    @IBOutlet weak var fuckshit: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        VK.api.getFeed() { response in
            let posts = response.items
            DispatchQueue.main.async { [self] in
                let manager = MediaDirector(widthPlaceholder: UIScreen.main.bounds.width, heightPlaceholder: UIScreen.main.bounds.height, attachments: posts[1].attachments!)
                let fuck = manager.build()
                print(fuck.frame)
                self.ihatemyself.addSubview(fuck)
                NSLayoutConstraint.activate([
                    fuck.topAnchor.constraint(equalTo: self.ihatemyself.topAnchor),
                    fuck.leadingAnchor.constraint(equalTo: ihatemyself.leadingAnchor),
                    fuck.trailingAnchor.constraint(equalTo: ihatemyself.trailingAnchor),
                    fuck.bottomAnchor.constraint(equalTo: ihatemyself.bottomAnchor),
                ])
                
            }
            
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
