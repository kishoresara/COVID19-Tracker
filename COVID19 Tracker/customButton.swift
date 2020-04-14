//
//  customButton.swift
//  COVID19 Tracker
//
//  Created by kishore saravanan on 11/04/20.
//  Copyright © 2020 kishore saravanan. All rights reserved.
//


import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        setShadow()
        setTitleColor(.white, for: .normal)
        
        backgroundColor       = UIColor.black
        titleLabel?.font      = UIFont(name: "AppleSDGothicNeo-Light", size: 22)
        layer.cornerRadius    = 25
        layer.borderWidth     = 3.0
        layer.borderColor     = UIColor.red.cgColor
        titleLabel?.textColor = UIColor.blue
    }
    
    
    private func setShadow() {
        layer.shadowColor   = UIColor.red.cgColor
        layer.shadowOffset  = CGSize(width: 0.5, height: 6.5)
        layer.shadowRadius  = 8
        layer.shadowOpacity = 0.5
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    
    func shake() {
        let shake           = CABasicAnimation(keyPath: "position")
        shake.duration      = 0.1
        shake.repeatCount   = 2
        shake.autoreverses  = true
        
        let fromPoint       = CGPoint(x: center.x - 8, y: center.y)
        let fromValue       = NSValue(cgPoint: fromPoint)
        
        let toPoint         = CGPoint(x: center.x + 8, y: center.y)
        let toValue         = NSValue(cgPoint: toPoint)
        
        shake.fromValue     = fromValue
        shake.toValue       = toValue
        layer.add(shake, forKey: "position")
    }
}
