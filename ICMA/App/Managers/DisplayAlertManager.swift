//
//  DisplayAlertManager.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit
import Foundation
import Localize_Swift

let alertTitleOk = "alert_button_ok"
let alertTitleCancel = "alert_button_cancel"
let alertTitleSave = "alert_button_save"
let alertTitleNo = "alert_button_no"
let alertTitleYes = "alert_button_yes"
let alertTitleCamera = "sheet_button_camera"
let alertTitlePhoto = "sheet_button_photo_library"

var keyAssociatedAlertPlaceHolder : Int = 0
var keyAssociatedAactionSave : Int = 0

class DisplayAlertManager : NSObject, UITextFieldDelegate {
    
    static var shared = DisplayAlertManager()
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func displayAlert(target : AnyObject? = nil, animated : Bool = true, message : String, handlerOK:(()->Void)? = nil) {
        
        if let controller : UIViewController = UIApplication.topViewController() {
            
            let alertController = UIAlertController(title: kAppName.localized(), message: message.localized(), preferredStyle: UIAlertController.Style.alert)
            
            let actionOK = UIAlertAction(title: alertTitleOk.localized(), style: UIAlertAction.Style.default) { (OK : UIAlertAction) in
                
                handlerOK?()
            }
            
            alertController .addAction(actionOK)
            controller .present(alertController, animated: animated, completion: nil)
        }
    }
    
    func displayAlertWithInputs(target : UIViewController, animated : Bool, message : String, inputPlaceHolders:[String], handlerCancel:(()->Void)?, handlerSave:(()->Void)?) {
        
        let alertController = UIAlertController(title: kAppName.localized(), message: message.localized(), preferredStyle: UIAlertController.Style.alert)
        
        let actionCancel = UIAlertAction(title: alertTitleCancel.localized(), style: UIAlertAction.Style.default) { (CANCEL : UIAlertAction) in
            
            handlerCancel?()
        }
        
        let actionSave = UIAlertAction(title: alertTitleSave.localized(), style: UIAlertAction.Style.default) { (SAVE : UIAlertAction) in
            
            //get all text from fields
            handlerSave?()
        }
        
        //add input
        var textPlaceHolders : [UITextField] = []
        var index : Int = 0
        
        for placeholder in inputPlaceHolders {
            
            alertController.addTextField { (textField : UITextField) in
                textField.placeholder = placeholder.localized()
                textField.delegate = target as? UITextFieldDelegate
                objc_setAssociatedObject(textField, &keyAssociatedAactionSave, actionSave, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                textField.tag = index
                textPlaceHolders.append(textField)
                index = index + 1
            }
        }
        objc_setAssociatedObject(alertController, &keyAssociatedAlertPlaceHolder, textPlaceHolders, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        
        alertController .addAction(actionCancel)
        
        actionSave.isEnabled = false
        alertController .addAction(actionSave)
        
        target.present(alertController, animated: animated, completion: nil)
    }
    
    func displayAlertWithCancelOk(target : UIViewController, animated : Bool, message : String, handlerCancel:@escaping (()->Void?), handlerOk:@escaping (()->Void?)) {
        
        let alertController = UIAlertController(title: kAppName.localized(), message: message.localized(), preferredStyle: UIAlertController.Style.alert)
        
        let actionCancel = UIAlertAction(title: alertTitleCancel.localized(), style: UIAlertAction.Style.default) { (CANCEL : UIAlertAction) in
            
            handlerCancel()
        }
        
        let actionSave = UIAlertAction(title: alertTitleSave.localized(), style: UIAlertAction.Style.default) { (SAVE : UIAlertAction) in
            
            handlerOk()
        }
        
        alertController .addAction(actionCancel)
        alertController .addAction(actionSave)
        
        target.present(alertController, animated: animated, completion: nil)
    }
    
    func displayAlertWithNoYes(target : UIViewController, animated : Bool, message : String, handlerNo:@escaping (()->Void), handlerYes:@escaping (()->Void)) {
        
        let alertController = UIAlertController(title: kAppName.localized(), message: message.localized(), preferredStyle: UIAlertController.Style.alert)
        
        let actionCancel = UIAlertAction(title: alertTitleNo.localized(), style: UIAlertAction.Style.default) { (CANCEL : UIAlertAction) in
            
            handlerNo()
        }
        
        let actionSave = UIAlertAction(title: alertTitleYes.localized(), style: UIAlertAction.Style.default) { (SAVE : UIAlertAction) in
            
            handlerYes()
        }
        
        alertController .addAction(actionCancel)
        alertController .addAction(actionSave)
        
        target.present(alertController, animated: animated, completion: nil)
    }
    
    func displayActionSheet(target : AnyObject, animated : Bool, message : String, handlerCamera:@escaping (()->Void), handlerPhotoLibrary:@escaping (()->Void), handlerCancel:@escaping (()->Void)) {
        
        var controller : UIViewController!;
        
        if target is UIViewController {
            controller = target as? UIViewController
        } else {
            return
        }
        
        let alertController = UIAlertController(title: kAppName.localized(), message: message.localized(), preferredStyle: UIAlertController.Style.actionSheet)
        
        let actionCamera = UIAlertAction(title: alertTitleCamera.localized(), style: UIAlertAction.Style.default) { (OK : UIAlertAction) in
            
            handlerCamera()
        }
        alertController .addAction(actionCamera)
        
        let actionPhotoLibrary = UIAlertAction(title: alertTitlePhoto.localized(), style: UIAlertAction.Style.default) { (OK : UIAlertAction) in
            
            handlerPhotoLibrary()
        }
        alertController .addAction(actionPhotoLibrary)
        
        let actionCancel = UIAlertAction(title: alertTitleCancel.localized(), style: UIAlertAction.Style.cancel) { (OK : UIAlertAction) in
            
            handlerCancel()
        }
        alertController .addAction(actionCancel)
    
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.modalPresentationStyle = .popover
            if let popoverController = alertController.popoverPresentationController {
                popoverController.sourceView = controller.view
                popoverController.sourceRect = CGRect(origin: alertController.view.center, size: CGSize(width: 0, height: 0))
                popoverController.permittedArrowDirections = .init(rawValue: 0)
            
                controller .present(alertController, animated: animated, completion: nil)
            }
        } else {
         
            controller .present(alertController, animated: animated, completion: nil)
        }
    }
    
    func displayActionSheet(target : AnyObject, titles: [String], animated : Bool, message : String, success: @escaping(_ selectedTitle: String?) -> Void) {
        
        var controller : UIViewController!;
        
        if target is UIViewController {
            controller = target as? UIViewController
        } else {
            return
        }
        
        let alertController = UIAlertController(title: kAppName.localized(), message: message.localized(), preferredStyle: UIAlertController.Style.actionSheet)
        
        for title in titles {
            
            let action = UIAlertAction(title: title.localized(), style: UIAlertAction.Style.default) { (OK : UIAlertAction) in
                success(OK.title)
            }
            alertController .addAction(action)
        }
        
        let actionCancel = UIAlertAction(title: alertTitleCancel.localized(), style: UIAlertAction.Style.cancel) { (OK : UIAlertAction) in
            success(nil)
        }
        alertController .addAction(actionCancel)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.modalPresentationStyle = .popover
            if let popoverController = alertController.popoverPresentationController {
                popoverController.sourceView = controller.view
                popoverController.sourceRect = CGRect(origin: alertController.view.center, size: CGSize(width: 0, height: 0))
                popoverController.permittedArrowDirections = .init(rawValue: 0)
                controller .present(alertController, animated: animated, completion: nil)
            }
        } else {
            controller .present(alertController, animated: animated, completion: nil)
        }
    }
    
    func showToast(message : String , view : UIView) {

        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2, y: view.frame.size.height-200, width: 220, height: 35))
        toastLabel.backgroundColor = UIColor.orange.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
