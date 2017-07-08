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
        collectionView?.register(ChatCell.self, forCellWithReuseIdentifier: chatCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: chatCellId, for: indexPath) as! ChatCell
        
        cell.message = messages?[indexPath.item]
        
        return cell
    }
    
}

extension ChatLogsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
}
