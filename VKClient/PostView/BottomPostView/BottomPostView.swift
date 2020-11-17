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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        getView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        getView()
    }
    private func getView(){
        viewFromNib = UINib(nibName: "BottomPostView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as? UIView
        let bottomPostView = viewFromNib!.subviews[0]
        bottomPostView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomPostView)
        NSLayoutConstraint.activate([
            bottomPostView.topAnchor.constraint(equalTo: topAnchor),
            bottomPostView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomPostView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomPostView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

}
