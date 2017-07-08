//
//  ChatCell.swift
//  Messenger
//
//  Created by Matt Tian on 7/8/17.
//  Copyright © 2017 Bizersoft. All rights reserved.
//

import UIKit

class ChatCell: BaseCell {
    
    var message: Message? {
        didSet {
            messageTextView.text = message?.text
        }
    }
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Good morning"
        textView.backgroundColor = UIColor(white: 0.5, alpha: 0.1)
        return textView
    }()
    
    override func setupViews() {
        addSubview(messageTextView)
        
        addConstraints("H:|[v0]|", for: messageTextView)
        addConstraints("V:|[v0]|", for: messageTextView)
    }
    
}
