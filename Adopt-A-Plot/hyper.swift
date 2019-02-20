//
//  hyper.swift
//  Adopt-A-Plot
//
//  Created by Ari Wasch on 2/1/19.
//  Copyright © 2019 Ari Wasch. All rights reserved.
//

import UIKit
import Foundation
class hyper:UIViewController, UITextViewDelegate {
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        let attributedString = NSMutableAttributedString(string: textView.text)
        textView.attributedText = attributedString
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL, options: [:])
        return false
    }
}

