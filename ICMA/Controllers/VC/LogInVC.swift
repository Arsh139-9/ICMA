//
//  LogInVC.swift
//  ICMA
//
//  Created by Dharmani Apps on 05/10/21.
//

import UIKit
import Foundation
import IQKeyboardManagerSwift

class LogInVC : BaseVC, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var btnRemember: ICRememberMeButton!
    @IBOutlet weak var txtPassword: ICPasswordTextField!
    @IBOutlet weak var txtEmail: ICEmailTextField!
    let rest = RestManager()

    var iconClick = true
    var returnKeyHandler: IQKeyboardReturnKeyHandler?
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        returnKeyHandler = IQKeyboardReturnKeyHandler(controller: self)
        returnKeyHandler?.delegate = self
        
        txtEmail.delegate = self
        txtPassword.delegate = self
        //        btnRememberMe.delegate = self
//        if PreferenceManager.shared.rememberMeEmail.isEmpty == false {
//            txtEmail.text = PreferenceManager.shared.rememberMeEmail
//            btnRemember.isRemember = true
//        } else {
//            btnRemember.isRemember = false
//        }
//        
//        if PreferenceManager.shared.rememberMePassword.isEmpty == false {
//            txtPassword.text = PreferenceManager.shared.rememberMePassword
//            btnRemember.isRemember = true
//        } else {
//            btnRemember.isRemember = false
//        }
        
    }
    
    func validate() -> Bool {
        
        if ValidationManager.shared.isEmpty(text: txtEmail.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please enter email address", okButton: "OK", controller: self ){
            }
            return false
        }
        
        if ValidationManager.shared.isValid(text: txtEmail.text!, for: RegularExpressions.email) == false {
            showAlertMessage(title: kAppName.localized(), message: "Please enter valid email address", okButton: "OK", controller: self ){
                
            }
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: txtPassword.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please enter password", okButton: "OK", controller: self ){
                
            }
            return false
        }
        
        return true
    }

    open func loginApi(){
        guard let url = URL(string: kBASEURL + WSMethods.signIn) else { return }
        var deviceToken  = getSAppDefault(key: "DeviceToken") as? String ?? ""
        if deviceToken == ""{
            deviceToken = "123"
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        rest.httpBodyParameters.add(value: txtEmail.text ?? "", forKey: "email")
        rest.httpBodyParameters.add(value: txtPassword.text ?? "", forKey: "password")
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
                print(jsonResult!)
                
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
                            }),
                            from: self
                        )
                    }
                    //                    DispatchQueue.main.async {
                    
                    
                    
                    
                    //                        let storyBoard = UIStoryboard(name: "Setting", bundle: nil)
                    //                        let vc = storyBoard.instantiateViewController(withIdentifier:"TabBarVC") as? TabBarVC
                    //                        if let vc = vc {
                    //                            self.navigationController?.pushViewController(vc, animated: true)
                    //                        }
                    
                    //}
                }
                
                else if loginResp?.status == 2{
                    DispatchQueue.main.async {
                        
                        //                    Alert.present(title: <#T##String?#>, message: <#T##String#>, actions: .retry(handler: {
                        //
                        //                    }),.ok(handler: {
                        //
                        //                    }), from: self)
                        
                        
                        let alert = UIAlertController(title: AppAlertTitle.appName.rawValue, message: loginResp?.alertMessage, preferredStyle: UIAlertController.Style.alert)
                        
                        alert.addAction(UIAlertAction(title: "Skip", style: UIAlertAction.Style.default, handler: { _ in
                            //Cancel Action
                        }))
                        alert.addAction(UIAlertAction(title: "Resend",
                                                      style: UIAlertAction.Style.destructive,
                                                      handler: {(_: UIAlertAction!) in
                                                        //Sign out action
                                                        self.resendEmailVerificationApi()
                                                      }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                else{
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
    open func resendEmailVerificationApi(){
        
        
        guard let url = URL(string: kBASEURL + WSMethods.resentVerficationEmail) else { return }
        
        rest.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        rest.httpBodyParameters.add(value:txtEmail.text ?? "", forKey:"email")
        
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
                
                let forgotResp = ForgotPasswordData.init(dict: jsonResult ?? [:])
                
                if forgotResp?.status == 1{
                    DispatchQueue.main.async {
                        Alert.present(
                            title: AppAlertTitle.appName.rawValue,
                            message: forgotResp?.message ?? "",
                            actions: .ok(handler: {
                                self.navigationController?.popViewController(animated: true)
                            }),
                            from: self
                        )
                    }                }else{
                        DispatchQueue.main.async {
                            
                            Alert.present(
                                title: AppAlertTitle.appName.rawValue,
                                message: forgotResp?.message ?? "",
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
    
    //MARK: Action
    
    @IBAction func btnSignUp(_ sender: Any) {
        let controller = NavigationManager.shared.signUpVC
        push(controller: controller)
    }
    @IBAction func btnLogin(_ sender: Any) {
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
            
            loginApi()
        }
        
        
        
        
    }
    @IBAction func rememberBtnAction(_ sender: UIButton) {
        if sender.tag == 0{
            sender.tag = 1
            btnRemember.setImage(#imageLiteral(resourceName: "check"), for: .normal)
            setAppDefaults("1", key: "rememberMe")
        }else{
            sender.tag = 0
            btnRemember.setImage(#imageLiteral(resourceName: "uncheck"), for: .normal)

            setAppDefaults("0", key: "rememberMe")

        }
    }
    
    @IBAction func btnForgot(_ sender: Any) {
        let controller = NavigationManager.shared.forgotPasswordVC
        push(controller: controller)
    }
    
    //------------------------------------------------------
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case txtEmail:
            viewEmail.borderColor =  ICColor.appButton
        case txtPassword:
            viewPassword.borderColor =  ICColor.appButton
        default:break
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case txtEmail:
            viewEmail.borderColor =  ICColor.appBorder
        case txtPassword:
            viewPassword.borderColor = ICColor.appBorder
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
