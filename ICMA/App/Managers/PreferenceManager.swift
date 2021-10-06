//
//  PreferenceManager.swift
//  NewProject
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit
import AssistantKit

class PreferenceManager: NSObject {

    public static var shared = PreferenceManager()
    private let userDefault = UserDefaults.standard
       
    //------------------------------------------------------
    
    //MARK: Settings
    
    var userBaseURL: String {
        return "https://google.com"
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    private let keyDeviceToken = "deviceToken"
    private let keyUserId = "userId"
    private let keyRememberMe = "rememberMe"
    private let keyRememberMePassword = "rememberMePassword"

    var deviceToken: String? {
        set {
            if newValue != nil {
                userDefault.set(newValue!, forKey: keyDeviceToken)
            } else {
                userDefault.removeObject(forKey: keyDeviceToken)
            }
            userDefault.synchronize()
        }
        get {
            let token = userDefault.string(forKey: keyDeviceToken)
            if token?.isEmpty == true || token == nil {
                return Device.versionCode
            } else {
                return userDefault.string(forKey: keyDeviceToken)
            }
        }
    }

    var userId: String? {
        set {
            if newValue != nil {
                userDefault.set(newValue!, forKey: keyUserId)
            } else {
                userDefault.removeObject(forKey: keyUserId)
            }
            userDefault.synchronize()
        }
        get {
            return userDefault.string(forKey: keyUserId)
        }
    }
    
    var rememberMeEmail: String {
        set {
            userDefault.set(newValue, forKey: keyRememberMe)
            userDefault.synchronize()
        }
        get {
            return userDefault.string(forKey: keyRememberMe) ?? String()
        }
    }
    
    var rememberMePassword: String {
        set {
            userDefault.set(newValue, forKey: keyRememberMePassword)
            userDefault.synchronize()
        }
        get {
            return userDefault.string(forKey: keyRememberMePassword) ?? String()
        }
    }
    
    //------------------------------------------------------
}
