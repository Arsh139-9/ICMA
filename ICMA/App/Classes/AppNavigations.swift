//
//  AppNavigations.swift
//  ChanceUpon
//
//  Created by Dharmani Apps mini on 12/7/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

class Navigation {
    open var pushCallBack = { (identifier:String,storyBoardName:String,class:UIViewController,storyboard:UIStoryboard,navigationVC:UINavigationController) -> () in
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: identifier)
        navigationVC.pushViewController(vc, animated: true)
           return
       }
}


