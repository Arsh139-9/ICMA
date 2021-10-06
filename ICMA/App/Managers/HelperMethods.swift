//
//  HelperMethods.swift
//  Debatespace
//
//  Created by IMac on 12/12/19.
//  Copyright © 2019 abc. All rights reserved.
//

import Foundation
import UIKit


var questionnaire = [[String:Any]]()
var questionnaireDict = [String:Any]()
var checkInQuestionnaire = [[String:Any]]()
var checkInQuestionnaireDict = [String:Any]()
var mealNumber = 0
func validateEmail(_ email:String)->Bool
{
    let emailRegex="[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,7}"
    let emailTest=NSPredicate(format:"SELF MATCHES %@", emailRegex)
    return emailTest.evaluate(with:email)
}
 func alert(_ title : String, message : String, view:UIViewController)
{
    let alert = UIAlertController(title:title, message:  message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    view.present(alert, animated: true, completion: nil)
}
func showMessage(title: String, message: String, okButton: String, cancelButton: String, controller: UIViewController, okHandler: (() -> Void)?, cancelHandler: @escaping (() -> Void)) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    
    let dismissAction = UIAlertAction(title: okButton, style: UIAlertAction.Style.default) { (action) -> Void in
        if okHandler != nil {
            okHandler!()
        }
    }
    let cancelAction = UIAlertAction(title: cancelButton, style: UIAlertAction.Style.default) {
        (action) -> Void in
        cancelHandler()
    }
    
    alertController.addAction(dismissAction)
    alertController.addAction(cancelAction)

  //  UIApplication.shared.windows[0].rootViewController?.present(alertController, animated: true, completion: nil)
            controller.present(alertController, animated: true, completion: nil)
}
func showAlertMessage(title: String, message: String, okButton: String, controller: UIViewController, okHandler: (() -> Void)?){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let dismissAction = UIAlertAction(title: okButton, style: UIAlertAction.Style.default) { (action) -> Void in
        if okHandler != nil {
            okHandler!()
        }
    }
    alertController.addAction(dismissAction)
   // UIApplication.shared.windows[0].rootViewController?.present(alertController, animated: true, completion: nil)
    controller.present(alertController, animated: true, completion: nil)

}
func storeCredential(email : String, password : String){
     
     UserDefaults.standard.set(email, forKey: "userEmail")
     UserDefaults.standard.set(password, forKey: "userPassword")
     UserDefaults.standard.synchronize()

 }
func removeCredential(){
     
     if UserDefaults.standard.value(forKey:"userEmail") != nil {
         UserDefaults.standard.removeObject(forKey: "userEmail")
     }
     
     if UserDefaults.standard.value(forKey:"userPassword") != nil {
         UserDefaults.standard.removeObject(forKey: "userPassword")
     }
     UserDefaults.standard.synchronize()
 }

func addShadowToView(targetView: UIView,shadowOffset: CGSize,shadowOpacity : Float, shadowRadius: CGFloat,shadowColor: CGColor) {
    targetView.layer.masksToBounds = false
    targetView.layer.shadowOffset = shadowOffset
    targetView.layer.shadowOpacity = shadowOpacity
    targetView.layer.shadowRadius = shadowRadius
    targetView.layer.shadowColor = shadowColor
}
//extension String{
//    var trimWhiteSpace: String{
//        return self.trimmingCharacters(in: .whitespacesAndNewlines)
//    }
//    var htmlStripped : String{
//        let tagFree = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
//        return tagFree.replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
//    }
//}
