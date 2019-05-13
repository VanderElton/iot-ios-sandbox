//
//  WegButton.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 10/05/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import UIKit

@IBDesignable
class WegButton: UIButton {
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var cornerRadiusByHeight: Bool = false {
        didSet {
            layer.cornerRadius = self.frame.size.height/2
        }
    }
    
    @IBInspectable var roundButton: Bool = false {
        didSet {
            layer.cornerRadius = self.frame.size.width / 2
            self.clipsToBounds = true
            self.layer.masksToBounds = true
        }
    }
    
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        
        didSet {
            
            layer.shadowColor = shadowColor.cgColor
            layer.masksToBounds = false
        }
    }
    
    
    @IBInspectable var shadowOpacity: CGFloat = 0.0 {
        
        didSet {
            
            layer.shadowOpacity = Float(shadowOpacity.hashValue)
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            layer.shadowOpacity = Float(shadowRadius.hashValue)
            layer.masksToBounds = false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
