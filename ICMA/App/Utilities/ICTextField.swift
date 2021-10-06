//
//  PMTextField.swift
//  NewProject
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import Foundation
import UIKit
import Toucan
import MonthYearPicker
import GCCountryPicker

protocol UploadImages {
    func pickImage (tag : Int)
}
protocol SelectedDateProtocal {
    func selectedDate (date : Date)
}

public var todaysDate = Date()
public var startTimes = [Date]()
public var endTimes = [Date]()
public var selectedDatess = [Date]()
public var selectedDatesssssss = Date()

class ICBaseTextField: UITextField {
    
    var fontDefaultSize : CGFloat {
        return font?.pointSize ?? 0.0
    }
    var fontSize : CGFloat = 0.0
    
    public var padding: Double = 8
    
    private var leftEmptyView: UIView {
        return UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: padding, height: Double.zero)))
    }
    
    //
    //    private var rightEmptyViewForButton : UIView {
    //        return leftButton
    //    }
    
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
        self.borderColor = ICColor.appButton
        self.shadowColor = ICColor.appWhite
        self.shadowOffset = CGSize.zero
        self.shadowOpacity = ICSettings.shadowOpacity
        self.tintColor = ICColor.appWhite
        self.textColor = ICColor.appWhite
    }
    fileprivate func HighlightLayer() {
        self.borderColor = ICColor.appButton
        self.tintColor = ICColor.appButton
    }
    
    fileprivate func resetLayer() {
        self.borderColor = ICColor.appBorder
        self.tintColor = ICColor.appBorder
    }
    
    
    
    private func setup() {
        
        fontSize = getDynamicFontSize(fontDefaultSize: fontDefaultSize)
        
        leftView = leftEmptyView
        leftViewMode = .always
        
        rightView = rightEmptyView
        rightViewMode = .always
        
        setupDefault()
    }
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fontSize = getDynamicFontSize(fontDefaultSize: fontDefaultSize)
    }
}
class ICProDisplayRegularTextField: ICBaseTextField {
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = ICFont.PoppinsRegular(size: fontSize)
    }
}



class ICProDisplaySemiBoldTextField: ICBaseTextField {
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = ICFont.PoppinsSemiBold(size: fontSize)
    }
}
class ICRegularTextField: ICBaseTextField {
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = ICFont.PoppinsRegular(size: fontSize)
    }
}
class ICMediumTextField: ICBaseTextField {
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = ICFont.PoppinsMedium(size: fontSize)
    }
}
class ICSemiboldTextField: ICBaseTextField {
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = ICFont.PoppinsSemiBold(size: fontSize)
    }
}

class ICEmailTextField: ICMediumTextField {
    
    var leftEmailView: UIView {
        let imgView = UIImageView(image: UIImage(named: ICImageName.iconMail))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    let paddings = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 5)
    private static let height: CGFloat = 20
    private static let crossButtonSize = CGSize(width: height, height: height)
    private let crossButtonView = UIButton(frame: CGRect(origin: CGPoint.zero, size: crossButtonSize))
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftEmailView
        leftViewMode = .always
        self.keyboardType = .emailAddress
        self.autocorrectionType = .no

    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding - 5), y: CGFloat(padding * 1.2)), size: CGSize(width: CGFloat(padding) * 2, height: bounds.height -  CGFloat(padding * 2.5)))
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
     
     override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
     
     override func textRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }

}
class ICPasswordTextField: ICMediumTextField {
    
    var leftPasswordView: UIView {
        let imgView = UIImageView(image: UIImage(named: ICImageName.iconPassword))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
  
    
    let paddings = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 5)
    private static let height: CGFloat = 20
    private static let crossButtonSize = CGSize(width: height, height: height)
    private let crossButtonView = UIButton(frame: CGRect(origin: CGPoint.zero, size: crossButtonSize))
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftPasswordView
        leftViewMode = .always
        self.keyboardType = .default
        self.isSecureTextEntry = true
        self.autocorrectionType = .no

    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding - 5), y: CGFloat(padding * 1.2)), size: CGSize(width: CGFloat(padding) * 2, height: bounds.height -  CGFloat(padding * 2.5)))
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
     
     override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
     
     override func textRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
}
}
class ICUsernameTextField: ICMediumTextField {

    var leftUserView: UIView {
        let imgView = UIImageView(image: UIImage(named:ICImageName.iconUser))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    let paddings = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 5)
    private static let height: CGFloat = 20
    private static let crossButtonSize = CGSize(width: height, height: height)
    private let crossButtonView = UIButton(frame: CGRect(origin: CGPoint.zero, size: crossButtonSize))
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftUserView
        leftViewMode = .always
        self.keyboardType = .default
        self.autocorrectionType = .no

    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding - 5), y: CGFloat(padding * 1.2)), size: CGSize(width: CGFloat(padding) * 2, height: bounds.height -  CGFloat(padding * 2.5)))
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
     
     override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
     
     override func textRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }

    
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
        
    }
}

