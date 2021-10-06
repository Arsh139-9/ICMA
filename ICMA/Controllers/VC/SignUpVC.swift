//
//  SignUpVC.swift
//  ICMA
//
//  Created by Dharmani Apps on 05/10/21.
//

import UIKit
import Foundation
import IQKeyboardManagerSwift

class SignUpVC : BaseVC, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var txtLastName: ICUsernameTextField!
    @IBOutlet weak var txtFirstName: ICUsernameTextField!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var checkUncheckBtn: UIButton!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var txtEmail: ICEmailTextField!
    @IBOutlet weak var txtPassword: ICPasswordTextField!
    let rest = RestManager()
    
    var returnKeyHandler: IQKeyboardReturnKeyHandler?
    var unchecked = Bool()
    var iconClick = true
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    open func signUpApi(){
        DispatchQueue.main.async {
            AFWrapperClass.svprogressHudShow(title:"Loading...", view:self)
        }
        AFWrapperClass.requestPOSTURL(kBASEURL + WSMethods.signUp, params: generatingParameters(), headers: nil) { response in
            AFWrapperClass.svprogressHudDismiss(view: self)
            print(response)
            let message = response["message"] as? String ?? ""
            if let status = response["status"] as? Int {
                if status == 200{
                    showAlertMessage(title: kAppName.localized(), message: message , okButton: "OK", controller: self) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    alert(AppAlertTitle.appName.rawValue, message: message, view: self)
                }
            }
            
        } failure: { error in
            AFWrapperClass.svprogressHudDismiss(view: self)
            alert(AppAlertTitle.appName.rawValue, message: error.localizedDescription, view: self)
        }
    }
    func generatingParameters() -> [String:AnyObject] {
        var parameters:[String:AnyObject] = [:]
        parameters["email"] = txtEmail.text  as AnyObject
        parameters["password"] = txtPassword.text  as AnyObject
        parameters["firstname"] = txtFirstName.text  as AnyObject
        parameters["lastname"] = txtLastName.text  as AnyObject

        parameters["devicetype"] = "1"  as AnyObject
        var deviceToken  = getSAppDefault(key: "DeviceToken") as? String ?? ""
        if deviceToken == ""{
            deviceToken = "123"
        }
        parameters["devicetoken"] = deviceToken  as AnyObject
        print(parameters)
        return parameters
    }
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        returnKeyHandler = IQKeyboardReturnKeyHandler(controller: self)
        returnKeyHandler?.delegate = self
        
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        
        
    }
    
    func validate() -> Bool {
        
        if ValidationManager.shared.isEmpty(text: txtFirstName.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please enter first name." , okButton: "Ok", controller: self) {
            }
            
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: txtLastName.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please enter last name." , okButton: "Ok", controller: self) {
            }
            
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: txtEmail.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please enter email address." , okButton: "Ok", controller: self) {
            }
            
            return false
        }
        
        if ValidationManager.shared.isValid(text: txtEmail.text!, for: RegularExpressions.email) == false {
            showAlertMessage(title: kAppName.localized(), message: "Please enter valid email address." , okButton: "Ok", controller: self) {
            }
            
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: txtPassword.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please enter password." , okButton: "Ok", controller: self) {
            }
            
            return false
        }
        
        if ValidationManager.shared.isValid(text: txtPassword.text!, for: RegularExpressions.password8AS) == false {
            showAlertMessage(title: kAppName.localized(), message: "Please enter valid password. Password should contain at least 8 characters, with at least 1 letter and 1 special character." , okButton: "Ok", controller: self) {
            }
            
            return false
        }
        
        return true
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func btnCheckUncheck(_ sender: UIButton) {
        if sender.tag == 0{
            sender.tag = 1
            checkUncheckBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
            setAppDefaults("1", key: "rememberMe")
        }else{
            sender.tag = 0
            checkUncheckBtn.setImage(#imageLiteral(resourceName: "uncheck"), for: .normal)
            
            setAppDefaults("0", key: "rememberMe")
            
        }
    }
    
    @IBAction func btnTermCondition(_ sender: Any) {
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        let isRemember  = getSAppDefault(key: "rememberMe") as? String ?? ""
        
        if validate() == false {
            return
        }
        else if isRemember == "0"{
            Alert.present(
                title: AppAlertTitle.appName.rawValue,
                message: AppRememberMeAlertMessage.rememberMe,
                actions: .ok(handler: {
                }),
                from: self
            )
        }
        else{
            signUpApi()
        }
    }
    @IBAction func btnSignIn(_ sender: Any) {
        self.pop()
    }
    
    //------------------------------------------------------
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case txtFirstName:
            nameView.borderColor = ICColor.appButton
        case txtLastName:
            lastNameView.borderColor = ICColor.appButton
        case txtEmail:
            emailView.borderColor = ICColor.appButton
        case txtPassword:
            passwordView.borderColor = ICColor.appButton
            
        default:break
            
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case txtFirstName:
            nameView.borderColor = ICColor.appBorder
        case txtLastName:
            lastNameView.borderColor = ICColor.appBorder
        case txtEmail:
            emailView.borderColor = ICColor.appBorder
        case txtPassword:
            passwordView.borderColor = ICColor.appBorder
        default:break
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppDefaults("0", key: "rememberMe")
        
        setup()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}
