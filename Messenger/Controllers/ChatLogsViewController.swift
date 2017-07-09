//
//  ChatLogsViewController.swift
//  Messenger
//
//  Created by Matt Tian on 7/8/17.
//  Copyright © 2017 Bizersoft. All rights reserved.
//

import UIKit

class ChatLogsViewController: UICollectionViewController {
    
    var friend: Friend? {
        didSet {
            if let _messages = friend?.messages?.allObjects as? [Message] {
                messages = _messages.sorted { $0.date! < $1.date! }
            }
        }
    }
    var messages: [Message]?
    
    let chatCellId = "chatCellId"
    
    let inputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let topBoarderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter message..."
        return textField
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.rgb(0, 137, 249), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = friend?.name
        tabBarController?.tabBar.isHidden = true
        
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(ChatCell.self, forCellWithReuseIdentifier: chatCellId)
        
        setupInputViews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    var bottomConstraint: NSLayoutConstraint?
    
    private func setupInputViews() {
        view.addSubview(inputContainerView)
        
        view.addConstraints("H:|[v0]|", for: inputContainerView)
        view.addConstraints("V:[v0(48)]", for: inputContainerView)
        
        bottomConstraint = inputContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomConstraint?.isActive = true
        
        inputContainerView.addSubview(topBoarderView)
        inputContainerView.addConstraints("H:|[v0]|", for: topBoarderView)
        inputContainerView.addConstraints("V:|[v0(0.5)]", for: topBoarderView)
        
        inputContainerView.addSubview(inputTextField)
        inputContainerView.addSubview(sendButton)
        inputContainerView.addConstraints("H:|-8-[v0]-8-[v1]-8-|", for: inputTextField, sendButton)
        inputContainerView.addConstraints("V:|[v0]|", for: inputTextField)
        inputContainerView.addConstraints("V:|[v0]|", for: sendButton)
    }
    
    func handleKeyboardNotification(notification: Notification) {
        let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
        
        if let userInfo = notification.userInfo {
            if let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect {
                bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame.height : 0
                
                UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                    
                    self.view.layoutIfNeeded()
                    
                }, completion: { _ in
                    if isKeyboardShowing {
                        let indexPath = IndexPath(item: self.messages!.count - 1, section: 0)
                        self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
                    }
                })
            }
        }
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
                cell.bubbleImageView.frame = CGRect(x: 44, y: -2, width: estimatedFrame.width + 16 + 8 + 8 + 4, height: estimatedFrame.height + 20)
                
                cell.messageTextView.frame = CGRect(x: 44 + 8 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            } else {
                cell.bubbleImageView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 8 - 16 - 16 - 2, y: -2, width: estimatedFrame.width + 16 + 8 + 8 + 4, height: estimatedFrame.height + 20)
                
                cell.messageTextView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 16, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            }
            
            cell.bubbleImageView.image = isSender ? cell.rightBubbleImage : cell.leftBubbleImage
            cell.bubbleImageView.tintColor = isSender ? UIColor.rgb(0, 137, 249) : UIColor(white: 0.95, alpha: 1)
            cell.messageTextView.textColor = isSender ? .white : .black
            cell.profileImageView.isHidden = isSender
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextField.endEditing(true)
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
