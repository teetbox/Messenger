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
    
    var message: Message? {
        didSet {
            if let profileName = message?.friend?.profileImageName {
                let image = UIImage(named: profileName)
                profileImageView.image = image
                hasReadImageView.image = image
            }
            
            nameLabel.text = message?.friend?.name
            messageLabel.text = message?.text
            
            if let date = message?.date {
                let dateFormatter = DateFormatter()
                
                let interval = Date().timeIntervalSince(date)
                let dayInterval: TimeInterval = 24 * 60 * 60
                
                if interval > 7 * dayInterval {
                    dateFormatter.dateFormat = "MM/dd/yy"
                } else if interval > dayInterval {
                    dateFormatter.dateFormat = "EEE"
                } else {
                    dateFormatter.dateFormat = "h:mm a"
                }
            
                dateLabel.text = dateFormatter.string(from: date)
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.rgb(0, 137, 249) : .white
            nameLabel.textColor = isHighlighted ? .white : .black
            dateLabel.textColor = isHighlighted ? .white : .black
            messageLabel.textColor = isHighlighted ? .white : .darkGray
        }
    }
    
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
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mark Zuckerberg"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "12:25 pm"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Here is a happy message for you."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    let hasReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "zuckprofile")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func setupViews() {
        
        addSubview(profileImageView)
        addConstraints("H:|-12-[v0(68)]", for: profileImageView)
        addConstraints("V:[v0(68)]", for: profileImageView)
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(dividerLineView)
        addConstraints("H:|-82-[v0]|", for: dividerLineView)
        addConstraints("V:[v0(1)]|", for: dividerLineView)
        
        setupContainerView()
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        addConstraints("H:|-90-[v0]-12-|", for: containerView)
        addConstraints("V:[v0(50)]", for: containerView)
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(hasReadImageView)
        
        containerView.addConstraints("H:|[v0][v1(60)]|", for: nameLabel, dateLabel)
        containerView.addConstraints("V:|[v0][v1(24)]", for: nameLabel, messageLabel)
        containerView.addConstraints("H:|[v0]-8-[v1(20)]|", for: messageLabel, hasReadImageView)
        containerView.addConstraints("V:|[v0(24)]", for: dateLabel)
        containerView.addConstraints("V:[v0(20)]", for: hasReadImageView)
        hasReadImageView.centerYAnchor.constraint(equalTo: messageLabel.centerYAnchor).isActive = true
    }
    
}
