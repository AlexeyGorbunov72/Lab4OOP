//
//  MediaView.swift
//  VKClient
//
//  Created by Alexey on 17.11.2020.
//

import Foundation
import UIKit
class MediaView: UIView{
    var urlMedia: URL
    func loadMedia(){
        fatalError("LoadMedia must override!")
    }
    init(frame: CGRect, urlMedia: String){
        self.urlMedia = URL(string: urlMedia)!
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Do not use that or i kill u!")
    }
}
