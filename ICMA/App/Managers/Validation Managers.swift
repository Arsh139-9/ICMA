//
//  Validation Managers.swift
//  daVinci
//
//  Created by Vivek Dharmani on 03/05/21.
//  Copyright © 2021 abc. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func ValidData(strMessage: String){
        let alert = UIAlertController(title: "ICMA", message: strMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func isEmailValid (testStr : String) -> Bool{
        let emailRegex = "[A-Z0-9a-z.%+_]+@[A-Z0-9a-z.-]+\\.[a-zA-Z]{2,3}"
        let validateEmail = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isemail = validateEmail.evaluate(with:testStr)
        return isemail
    }
    func  isPasswordValid (testStr : String) -> Bool{
        let passwordRegex = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,}$"
        let validatePassword = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        let isPassword = validatePassword.evaluate(with:testStr)
        return isPassword
    }
    func  isUserNameValid (testStr : String) -> Bool{
        let userNameRegex = "^\\w(3,20)$"
        let validateUserName = NSPredicate(format:"SELF MATCHES %@", userNameRegex)
        let isValidateUserName = validateUserName.evaluate(with: testStr)
        return isValidateUserName
    }
    func isConfirmPassword (testStr : String) -> Bool{
        let passwordRegex = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,}$"
        let validatePassword = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        let isPassword = validatePassword.evaluate(with:self)
        return isPassword
        
    }
    func isPhoneValid (testStr : String) -> Bool{
        let phoneRegex = "^((\\+)|(00))[0-9]{6,14}$"
        let validatePhone = NSPredicate(format:"SELF MATCHES %@", phoneRegex)
        let isPhone = validatePhone.evaluate(with:self)
        return isPhone
    
 
}
   
}
