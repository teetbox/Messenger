//
//  ChatLogsViewController.swift
//  Messenger
//
//  Created by Matt Tian on 7/8/17.
//  Copyright © 2017 Bizersoft. All rights reserved.
//

import UIKit

class ChatLogsViewController: UICollectionViewController {
    
    var friend: Friend?
    var messages: [Message]?
    
    let chatCellId = "chatCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _messages = friend?.messages?.allObjects as? [Message] {
            messages = _messages.sorted { $0.date! < $1.date! }
        }
        
        navigationItem.title = friend?.name
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(ChatCell.self, forCellWithReuseIdentifier: chatCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: chatCellId, for: indexPath) as! ChatCell
        
        let message = messages?[indexPath.item]
        cell.message = message
        
        if let messageText = message?.text, let isSender = message?.isSender {
            let size = CGSize(width: 220, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil)
            
            if !isSender {
                cell.bubbleImageView.frame = CGRect(x: 44, y: 0, width: estimatedFrame.width + 16 + 8 + 8, height: estimatedFrame.height + 20)
                
                cell.messageTextView.frame = CGRect(x: 44 + 8 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            } else {
                cell.bubbleImageView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 8 - 16 - 16, y: 0, width: estimatedFrame.width + 16 + 8 + 8, height: estimatedFrame.height + 20)
                
                cell.messageTextView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 16, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            }
            
            cell.bubbleImageView.image = isSender ? cell.rightBubbleImage : cell.leftBubbleImage
            cell.bubbleImageView.tintColor = isSender ? UIColor.rgb(0, 137, 249) : UIColor(white: 0.95, alpha: 1)
            cell.messageTextView.textColor = isSender ? .white : .black
            cell.profileImageView.isHidden = isSender
        }
        
        return cell
    }
    
}

extension ChatLogsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let messageText = messages?[indexPath.item].text {
            let size = CGSize(width: 220, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil)
            
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 20)
        }
        
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
}
