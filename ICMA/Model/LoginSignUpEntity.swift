//
//  LoginSignUpEntity.swift
//  ICMA
//
//  Created by Apple on 06/10/21.
//

import Foundation

//{
//    "status": 200,
//    "message": "Logged in successfully.",
//    "data": {
//        "userid": "13",
//        "authtoken": "YFttB8LaLSqDoWXq",
//        "firstname": "Shikha",
//        "lastname": "Soni",
//        "email": "mandeep123@gmail.com",
//        "profileimage": "",
//        "password": "e10adc3949ba59abbe56e057f20f883e",
//        "emailverification": "",
//        "verificationcode": "",
//        "phone": "9874563201",
//        "created": ""
//    }
//}
struct LoginSignUpData<T>{
    
    var status:Int
    var alertMessage:String
    var user_id:String
    var authtoken:String
    var firstname:String
    var lastname:String
    var email:String
    var profileimage:String
    var password:String
    var emailverification:String
    var verificationcode:String
    var phone:String
    var created:String
    
    
    
    
    init?(dict:[String:T]) {
        let status  = dict["status"] as? Int ?? 0
        let alertMessage = dict["message"] as? String ?? ""
        
        let  dataDict = dict["data"] as? [String:T] ?? [:]
        
        
        let user_id = dataDict["user_id"] as? String ?? ""
        let authtoken = dataDict["authtoken"] as? String ?? ""
        let firstname = dataDict["firstname"] as? String ?? ""
        let lastname = dataDict["lastname"] as? String ?? ""
        let email = dataDict["email"] as? String ?? ""
        let profileimage = dataDict["profileimage"] as? String ?? ""
        let password = dataDict["password"] as? String ?? ""
        let emailverification = dataDict["emailverification"] as? String ?? ""
        let verificationcode = dataDict["verificationcode"] as? String ?? ""
        let phone = dataDict["phone"] as? String ?? ""
        let created = dataDict["created"] as? String ?? ""
        
        
        self.status = status
        self.alertMessage = alertMessage
        self.user_id = user_id
        self.authtoken = authtoken
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.profileimage = profileimage
        self.password = password
        self.emailverification = emailverification
        self.verificationcode = verificationcode
        self.phone = phone
        self.created = created
        
        
        
    }
}

extension LoginSignUpData {
    
    enum CodingKeys: CodingKey {
        case status
        case alertMessage
        case user_id
        case username
        case email
        case password
        case photo
        case description
        case verified
        case verificate_code
        case created_at
        case disabled
        case allow_push
        case device_type
        case device_token
        case authtoken
        case mobile_number
        
    }
}
