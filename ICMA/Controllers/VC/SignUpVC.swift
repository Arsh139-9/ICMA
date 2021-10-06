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
        guard let url = URL(string: kBASEURL + WSMethods.signUp) else { return }
        var deviceToken  = getSAppDefault(key: "DeviceToken") as? String ?? ""
        if deviceToken == ""{
            deviceToken = "123"
        }
        rest.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        rest.httpBodyParameters.add(value: txtEmail.text ?? "", forKey: "email")
        rest.httpBodyParameters.add(value: txtPassword.text ?? "", forKey: "password")
        rest.httpBodyParameters.add(value: txtFirstName.text ?? "", forKey: "firstname")
        rest.httpBodyParameters.add(value: txtLastName.text ?? "", forKey: "lastname")
        rest.httpBodyParameters.add(value: deviceToken, forKey: "devicetoken")
        rest.httpBodyParameters.add(value: "1", forKey: "devicetype")
        DispatchQueue.main.async {
            
            AFWrapperClass.svprogressHudShow(title:"Loading...", view:self)
        }
        rest.makeRequest(toURL: url, withHttpMethod: .post) { (results) in
            DispatchQueue.main.async {
                
                AFWrapperClass.svprogressHudDismiss(view: self)
            }
            
            guard let response = results.response else { return }
            if response.httpStatusCode == 200 {
                guard let data = results.data else { return }
                
                let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyHashable] ?? [:]
                //                    let dataString = String(data: data, encoding: .utf8)
                //                    let jsondata = dataString?.data(using: .utf8)
                //                    let decoder = JSONDecoder()
                //                    let jobUser = try? decoder.decode(LoginData, from: jsondata!)
                //
                let loginResp =   LoginSignUpData.init(dict: jsonResult ?? [:])
                if loginResp?.status == 1{
                    setAppDefaults(loginResp?.user_id, key: "UserId")
                    setAppDefaults(loginResp?.authtoken, key: "AuthToken")
                    setAppDefaults(loginResp?.firstname ?? "" + loginResp!.lastname, key: "UserName")
                    DispatchQueue.main.async {
                        Alert.present(
                            title: AppAlertTitle.appName.rawValue,
                            message: loginResp?.alertMessage ?? "",
                            actions: .ok(handler: {
                                self.popBack(0)
                            }),
                            from: self
                        )
                    }
                }else{
                    DispatchQueue.main.async {
                        Alert.present(
                            title: AppAlertTitle.appName.rawValue,
                            message: loginResp?.alertMessage ?? "",
                            actions: .ok(handler: {
                            }),
                            from: self
                        )
                    }
                }
                
            }else{
                DispatchQueue.main.async {
                    
                    Alert.present(
                        title: AppAlertTitle.appName.rawValue,
                        message: AppAlertTitle.connectionError.rawValue,
                        actions: .ok(handler: {
                        }),
                        from: self
                    )
                }
            }
        }
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
