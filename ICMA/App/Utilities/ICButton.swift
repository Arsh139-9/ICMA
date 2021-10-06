//
//  PMButton.swift
//  NewProject
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import Foundation
import UIKit

class ICBaseButton: UIButton {

    var fontDefaultSize : CGFloat {
        return self.titleLabel?.font.pointSize ?? 0.0
    }
    var fontSize : CGFloat = 0.0
    
    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fontSize = getDynamicFontSize(fontDefaultSize: fontDefaultSize)
    }
}

class ICRegularButton: ICBaseButton {

    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.titleLabel?.font = ICFont.PoppinsRegular(size: self.fontSize)
        self.imageView?.contentMode = .scaleAspectFit
    }
}

class ICMediumButton: ICBaseButton {

    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.titleLabel?.font = ICFont.PoppinsMedium(size: self.fontSize)
        self.imageView?.contentMode = .scaleAspectFit
    }
}
class ICLightButton: ICBaseButton {

    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.titleLabel?.font = ICFont.PoppinsLight(size: self.fontSize)
        self.imageView?.contentMode = .scaleAspectFit
    }
}

class ICSemiboldButton: ICBaseButton {

    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.titleLabel?.font = ICFont.PoppinsSemiBold(size: self.fontSize)
        self.imageView?.contentMode = .scaleAspectFit
    }
}

class ICActiveButton: ICSemiboldButton {

    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
                
        self.cornerRadius = ICSettings.cornerRadius
        self.shadowOffset = CGSize.zero
//        self.shadowOpacity = FGSettings.shadowOpacity
        
        self.backgroundColor = ICColor.appButton
        //self.setBackgroundImage(UIImage(named: TFImageName.background), for: .normal)
        self.clipsToBounds = true
    }
    
    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
             
       setup()
    }
}
class ICRememberMeButton: ICRegularButton {

    var isRemember: Bool = false {
        didSet {
            if isRemember {
                self.setImage(UIImage(named: ICImageName.iconCheck), for: .normal)
            } else {
                self.setImage(UIImage(named: ICImageName.iconUncheck), for: .normal)
            }
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        isRemember = false
        
        let padding: CGFloat = 4
        imageEdgeInsets = UIEdgeInsets(top: padding, left: CGFloat.zero, bottom: padding, right: padding)
        
        addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @objc func click(_ sender: ICRememberMeButton) {
        sender.isRemember.toggle()
    }
    
    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
}
