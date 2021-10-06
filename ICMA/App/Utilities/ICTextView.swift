//
//  FGTextView.swift
//  Fringe
//
//  Created by Dharmani Apps on 11/08/21.
//

import Foundation
import UIKit

class ICBaseTextView: UITextView {
    
    public var fontDefaultSize : CGFloat {
        return font?.pointSize ?? 0.0
    }
    public var fontSize : CGFloat = 0.0
    
    public var padding: Double = 8
    
    private var leftEmptyView: UIView {
        return UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: padding, height: Double.zero)))
    }
    private var rightEmptyView: UIView {
        return leftEmptyView
    }
    
    override func becomeFirstResponder() -> Bool {
        HighlightLayer()
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        resetLayer()
        return super.resignFirstResponder()
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    fileprivate func setupDefault() {
        
        self.cornerRadius = ICSettings.cornerRadius
        self.borderWidth = ICSettings.borderWidth
        self.borderColor = ICColor.appWhite
        self.shadowColor = ICColor.appWhite
        self.shadowOffset = CGSize.zero
        self.shadowOpacity = ICSettings.shadowOpacity
        self.tintColor = ICColor.appButton
        self.textColor = ICColor.appWhite
    }
    
    fileprivate func HighlightLayer() {
        self.borderColor = ICColor.appButton
        self.buttonColor = ICColor.appButton
        self.tintColor = ICColor.appButton
    }
    
    fileprivate func resetLayer() {
//        self.borderColor = SSColor.
        self.tintColor = ICColor.appWhite
        
    }
        
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}

class ICMediumWithoutBorderTextView: UITextView {

    public var fontDefaultSize : CGFloat {
        return font?.pointSize ?? 0.0
    }
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
                
        let fontSize = getDynamicFontSize(fontDefaultSize: fontDefaultSize)
        self.font = ICFont.PoppinsMedium(size: fontSize)
        self.tintColor = ICColor.appButton
    }
}

class ICRegularTextView: ICBaseTextView {

    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = ICFont.PoppinsRegular(size: fontSize)
    }
}



