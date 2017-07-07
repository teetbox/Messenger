//
//  UIView+AddConstraints.swift
//  Messenger
//
//  Created by Matt Tian on 7/7/17.
//  Copyright © 2017 Bizersoft. All rights reserved.
//

import UIKit

extension UIView {
    
    func addConstraints(_ format: String, for views: UIView...) {
        var viewDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    }
    
}
