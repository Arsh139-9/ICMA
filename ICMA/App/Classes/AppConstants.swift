//
//  AppConstants.swift
//  NewProject
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit

let kAppName : String = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? String()
let kAppBundleIdentifier : String = Bundle.main.bundleIdentifier ?? String()

enum DeviceType: String {
    case iOS = "iOS"
    case android = "android"
}

let emptyJsonString = "{}"

struct ICSettings {
    
    static let cornerRadius: CGFloat = 5
    static let borderWidth: CGFloat = 1
    static let shadowOpacity: Float = 0.4
    static let tableViewMargin: CGFloat = 50
    
    static let nameLimit = 20
    static let emailLimit = 70
    static let passwordLimit = 20
    
    static let footerMargin: CGFloat = 50
    static let profileImageSize = CGSize.init(width: 400, height: 400)
    static let profileBorderWidth: CGFloat = 4 }

struct ICColor {
    
    static let appButton = UIColor(named: "appButton")
    static let appWhite = UIColor(named: "appWhite")
    static let appBorder = UIColor(named: "appBorder")
    static let appLabel = UIColor(named: "appLabel")
    static let appBlack = UIColor(named: "appBlack")
    
}

struct ICFont {
    
    static let defaultRegularFontSize: CGFloat = 20.0
    static let zero: CGFloat = 0.0
    static let reduceSize: CGFloat = 3.0
    static let increaseSize : CGFloat = 2.0
    
    //"family: Poppins "
   
    static func PoppinsLight(size: CGFloat?) -> UIFont {
        return UIFont(name: "Poppins-Light", size: size ?? defaultRegularFontSize)!
    }
    static func PoppinsMedium(size: CGFloat?) -> UIFont {
        return UIFont(name: "Poppins-Medium", size: size ?? defaultRegularFontSize)!
    }
    static func PoppinsRegular(size: CGFloat?) -> UIFont {
        return UIFont(name: "Poppins-Regular", size: size ?? defaultRegularFontSize)!
    }
    static func PoppinsSemiBold(size: CGFloat?) -> UIFont {
        return UIFont(name: "Poppins-SemiBold", size: size ?? defaultRegularFontSize)!
    }
}

struct ICImageName {

    static let iconLogo = "logo"
    static let iconMail = "mail"
    static let iconPassword = "password"
    static let iconCheck = "check"
    static let iconUncheck = "uncheck"
    static let iconUser = "user"
 
}

struct ICScreenName {
      
    static let subscribed = "subscribed"
    static let home = "home"
    static let settings = "settings"
}
