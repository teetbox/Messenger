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
            
            if let imageName = message?.friend?.profileImageName {
                profileImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Good morning"
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.isEditable = false
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let leftBubbleImage = UIImage(named: "bubble_gray")!.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26))
    let rightBubbleImage = UIImage(named: "bubble_blue")!.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26))
    
    override func setupViews() {
        
        addSubview(bubbleImageView)
        addSubview(messageTextView)
        addSubview(profileImageView)
        
        addConstraints("H:|-8-[v0(30)]", for: profileImageView)
        addConstraints("V:[v0(30)]-4-|", for: profileImageView)
    }
    
}
