//
//  LoadingIndicatorVC.swift
//  NewProject
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2019 eSurgent. All rights reserved.
//

import UIKit
import Foundation
import Lottie

class LoadingIndicatorVC : UIViewController {
    
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var blurView: UIView!
    
    var isSetSplashScreenOpacity = true
    var animationIndicatorView: AnimationView?
    
    //------------------------------------------------------
    
    //MARK: - Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isSetSplashScreenOpacity {
            blurView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        }
        
        animationIndicatorView = AnimationView(name: "loader_ring")
        animationIndicatorView?.loopMode = .loop
        self.view.addSubview(animationIndicatorView!)
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animationIndicatorView?.play()
    }
    
    //------------------------------------------------------
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        animationIndicatorView?.frame = indicatorView.frame
    }
    
    //------------------------------------------------------
}
