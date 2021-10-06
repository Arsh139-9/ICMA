////
////  LoadingManager.swift
////  NewProject
////
////  Created by Dharmesh Avaiya on 22/08/20.
////  Copyright © 2020 dharmesh. All rights reserved.
////
//
import UIKit
import Foundation

class LoadingManager: NSObject {
    
    var topMostController : UIViewController? {
        return UIApplication.topViewController()
    }
    
    var controller: LoadingIndicatorVC?
    var alertController: UIAlertController?
    
    //------------------------------------------------------
    
    //MARK: Shared
    
    static let shared = LoadingManager()

    //------------------------------------------------------
    
    //MARK: Show
    
    func showLoading(isOpacity: Bool = true) {
        
        if controller == nil || controller?.presentingViewController != nil {
//            controller = NavigationManager.shared.loadingIndicatorVC
            controller?.modalPresentationStyle = .overFullScreen
            controller?.isSetSplashScreenOpacity = isOpacity
            topMostController?.present(controller!, animated: false, completion: nil)
        }
    }
    
    func showError(message: String) {
        
        if let target = topMostController {
            DisplayAlertManager.shared.displayAlert(target: target, animated: true, message: message) {
            }
        }
    }
    
    func showNetworkActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    //------------------------------------------------------
    
    //MARK: Hide
    
    func hideLoading() {
        controller?.dismiss(animated: false, completion: nil)
        controller = nil
    }
    
    func hideNetworkActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    //------------------------------------------------------
}
