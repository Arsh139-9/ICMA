//
//  PMLabel.swift
//  NewProject
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit

class ICBaseLabel: UILabel {

    private var fontDefaultSize: CGFloat {
        return font.pointSize
    }
    
    public var fontSize: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
       fontSize = getDynamicFontSize(fontDefaultSize: fontDefaultSize)
    }
}

class ICRegularLabel: ICBaseLabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = ICFont.PoppinsRegular(size: self.fontSize)
    }
}

class ICMediumLabel: ICBaseLabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = ICFont.PoppinsMedium(size: self.fontSize)
    }
}

class ICLightLabel: ICBaseLabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = ICFont.PoppinsLight(size: self.fontSize)
    }
}


class ICSemiboldLabel: ICBaseLabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = ICFont.PoppinsSemiBold(size: self.fontSize)
    }
}



