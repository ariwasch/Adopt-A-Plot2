//
//  hyper.swift
//  Adopt-A-Plot
//
//  Created by Ari Wasch on 1/31/19.
//  Copyright © 2019 Ari Wasch. All rights reserved.
//
import UIKit
import Foundation
class hyper2:UIViewController, UITextViewDelegate {
    @IBOutlet var textView: UITextView!

    override func viewDidLoad() {
        let attributedString = NSMutableAttributedString(string: textView.text)
        attributedString.addAttribute(.link, value: "https://www.youtube.com/watch?v=7U1RD9tQhk", range: NSRange(location: 100, length: 54))
        
        textView.attributedText = attributedString
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL, options: [:])
        return false
    }
}
