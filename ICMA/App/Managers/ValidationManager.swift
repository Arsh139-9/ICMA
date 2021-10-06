//
//  ValidationManager.swift
//  NewProject
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit

enum RegularExpressions: String {
    case url = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    case password8AS = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
    case password82US2N3L = "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$"
}

class ValidationManager: NSObject {
    
    let kNameMinLimit = 2
    let kPasswordMinLimit = 8
    let kPasswordMaxLimit = 20
    
    //------------------------------------------------------
           
    //MARK: Shared
              
    static let shared = ValidationManager()
   
    //------------------------------------------------------
    
    //MARK: Private
    
    private func isValid(input: String, matchesWith regex: String) -> Bool {
        let matches = input.range(of: regex, options: .regularExpression)
        return matches != nil
    }
    
    //------------------------------------------------------
    
    //MARK: Public
    
    func isEmpty(text : String?) -> Bool {
        return text?.toTrim().isEmpty ?? true
    }
    
    func isValid(text: String, for regex: RegularExpressions) -> Bool {
        
        return isValid(input: text, matchesWith: regex.rawValue)
    }
    
    func isValidConfirm(password : String, confirmPassword : String) -> Bool{
        if password == confirmPassword {
            return true
        } else {
            return false
        }
    }
    
    //------------------------------------------------------
}

