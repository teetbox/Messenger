//
//  FriendCell.swift
//  Messenger
//
//  Created by Matt Tian on 7/7/17.
//  Copyright © 2017 Bizersoft. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FriendCell: BaseCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "zuckprofile")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    override func setupViews() {
        
        addSubview(profileImageView)
        addConstraints("H:|-12-[v0(68)]", for: profileImageView)
        addConstraints("V:[v0(68)]", for: profileImageView)
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(dividerLineView)
        addConstraints("H:|-82-[v0]|", for: dividerLineView)
        addConstraints("V:[v0(1)]|", for: dividerLineView)
    }
    
}
































