//
//  ChatHeaderView.swift
//  Messenger
//
//  Created by Matt Tian on 7/12/17.
//  Copyright © 2017 Bizersoft. All rights reserved.
//

import UIKit

class ChatHeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
        print("Here is section header")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
