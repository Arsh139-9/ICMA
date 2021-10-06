//
//  PMAssistiveTouchView.swift
//  NewProject
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit

class SSAssistiveTouchView: UIButton {
    
    var originPoint = CGPoint.zero
    let screen = UIScreen.main.bounds
    
    //------------------------------------------------------
    
    //MARK: Custom
    
    func setup() {
        
        imageView?.contentMode = .scaleAspectFit
        shadowColor = UIColor.lightGray
        shadowOpacity = 1.0
        shadowOffset = CGSize.zero
    }
    
    func reactBounds(touches: Set<UITouch>) {
        guard let touch = touches.first else {
            debugPrint("touch can not be nil")
            return
        }
        let endPoint = touch.location(in: self)
        let offsetX = endPoint.x - originPoint.x
        let offsetY = endPoint.y - originPoint.y
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        if center.x + offsetX >= screen.width / 2 {
            self.center = CGPoint(x: screen.width - bounds.size.width / 2, y: center.y + offsetY)
        } else {
            self.center = CGPoint(x: bounds.size.width / 2, y: center.y + offsetY)
        }
        if center.y + offsetY >= screen.height - bounds.size.height / 2 {
            self.center = CGPoint(x: center.x, y: screen.height - bounds.size.height / 2)
        } else if center.y + offsetY < bounds.size.height / 2 {
            self.center = CGPoint(x: center.x, y: bounds.size.height / 2)
        }
        UIView.commitAnimations()
    }
    
    override open func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
    }
    
    //------------------------------------------------------
    
    //MARK: UITouch
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            debugPrint("touch can not be nil")
            return
        }
        originPoint = touch.location(in: self)
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            debugPrint("touch can not be nil")
            return
        }
        let nowPoint = touch.location(in: self)
        let offsetX = nowPoint.x - originPoint.x
        let offsetY = nowPoint.y - originPoint.y
        self.center = CGPoint(x: self.center.x + offsetX, y: self.center.y + offsetY)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        reactBounds(touches: touches)
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        reactBounds(touches: touches)
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    //------------------------------------------------------
}
