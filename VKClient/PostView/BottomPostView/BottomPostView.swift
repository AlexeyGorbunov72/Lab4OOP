//
//  BottomPostView.swift
//  VKClient
//
//  Created by Alexey on 17.11.2020.
//

import UIKit
@IBDesignable
class BottomPostView: UIView {
    var viewFromNib: UIView?
    
    override func draw(_ rect: CGRect) {
        getView()
    }
    private func getView(){
        viewFromNib = UINib(nibName: "BottomPostView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        let bottomPostView = viewFromNib!.subviews[0]
        bottomPostView.frame = bounds
        addSubview(bottomPostView)
    }

}
