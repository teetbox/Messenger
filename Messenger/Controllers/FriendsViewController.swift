//
//  FriendsViewController.swift
//  Messenger
//
//  Created by Matt Tian on 7/7/17.
//  Copyright © 2017 Bizersoft. All rights reserved.
//

import UIKit

class FriendsViewController: UICollectionViewController {
    
    let friendCellId = "friendCell"
    
    var messages: [Message]?
    
    override func viewDidLoad() {
        navigationItem.title = "Friends"
        
        collectionView?.register(FriendCell.self, forCellWithReuseIdentifier: friendCellId)
        
        setupCollectionView()
        
        setupData()
    }
    
    private func setupCollectionView() {
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: friendCellId, for: indexPath) as! FriendCell
        
        cell.message = messages?[indexPath.item]
        
        return cell
    }
    
}

extension FriendsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
