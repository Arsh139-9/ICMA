//
//  AppDefaults.swift
//  BumpAppReplica
//
//  Created by Dharmesh Avaiya on 21/01/20..
//  Copyright © 2018 iOSDeveloper. All rights reserved.
//

import Foundation

struct AppDefaults {
    static let selectedSecurityQues = "selectedSecurityQues"
    static let requestFromKnowMore = "requestFromKnowMore"
    static let isUserLoggedIn = "isUserLoggedIn"
}

func setAppDefaults<T>(_ value:T,key: String) {
    UserDefaults.standard.set(value, forKey: key)
    UserDefaults.standard.synchronize()
}

func getAppDefaults<T>(key:String) -> T? {
    guard let value = UserDefaults.standard.value(forKey: key) as? T else {
        return nil
    }
    return value
}
func getSAppDefault(key:String) -> Any{
    let value = UserDefaults.standard.value(forKey: key)
    return value as Any
}
func removeAppDefaults(key: String) {
    UserDefaults.standard.removeObject(forKey: key)
    UserDefaults.standard.synchronize()
}


