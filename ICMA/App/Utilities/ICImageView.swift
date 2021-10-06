//
//  PMImageView.swift
//  NewProject
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit
import AssistantKit

class ICBaseImageView: UIImageView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class ICBottomBarImageView: UIImageView {
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        let device = Device.version
        if device == Version.phone4 || device == Version.phone4S || device == Version.phone5 || device == Version.phone6 || device == Version.phone7 || device == Version.phone8 || device == Version.phone5C || device == Version.phone5S || device == Version.phone6Plus || device == Version.phone7Plus || device == Version.phone8Plus {
            //image = UIImage(named: PMImageName.barBottoMenuNotX)
        } else {
            //image = UIImage(named: PMImageName.barBottoMenu)
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    override init(image: UIImage?) {
        super.init(image: image)
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
         
        setup()
    }

    //------------------------------------------------------
}
