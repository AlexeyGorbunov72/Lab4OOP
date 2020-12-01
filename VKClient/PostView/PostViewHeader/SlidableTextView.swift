//
//  SlidableTextView.swift
//  VKClient
//
//  Created by Alexey on 30.11.2020.
//

import UIKit

class SlidableTextView: UITextView, UITextViewDelegate {
    var contentText = ""
    var callBack: ((UITextView) -> ())?
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        delegate = self
         
        
    }
    func setText(text: String){
        contentText = text
        addClicableText()
    }
    func addClicableText(){
        
        if contentText.count / (Int(frame.width) / 20) > 3{
            let countChars = 3 * (Int(frame.width) / 20)
            let index = self.contentText.index(contentText.startIndex, offsetBy: countChars)
            var mySubstring = String(contentText.prefix(upTo: index))
            mySubstring += "..."
            let font = UIFont.systemFont(ofSize: 20)
            let attributes = [NSAttributedString.Key.font: font]
            let attributedString = NSMutableAttributedString(string: mySubstring, attributes: attributes)
            let range = NSRange(location: mySubstring.count - 3, length: 3)
            attributedString.addAttribute(.link, value: "...", range: range)
            self.attributedText = attributedString
        } else {
            self.text = contentText
        }
        
    }
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        self.attributedText = nil
        self.text = contentText
        
        self.callBack!(self)
            
        return false
    }
}
extension UITextView{

    func numberOfLines() -> Int{
        if let fontUnwrapped = self.font{
            return Int(self.contentSize.height / fontUnwrapped.lineHeight)
        }
        return 0
    }

}
