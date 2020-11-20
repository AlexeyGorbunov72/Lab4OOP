//
//  ShowCntentController.swift
//  VKClient
//
//  Created by Alexey on 20.11.2020.
//

import UIKit

class ShowCntentController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: ContentView!
    var attachment: Attachment?
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        contentView.addMedia(attachment: attachment!)
        
//        let scrollViewFrame = scrollView.frame
//        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
//        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
//        let minScale = min(scaleWidth, scaleHeight);
//        scrollView.minimumZoomScale = minScale;
//
//        scrollView.maximumZoomScale = 2.0
//        scrollView.zoomScale = minScale;
//
//        centerScrollViewContents()
        
    }
    
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = contentView.frame

        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }

        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }

        contentView.frame = contentsFrame
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentView
    }
    
}
