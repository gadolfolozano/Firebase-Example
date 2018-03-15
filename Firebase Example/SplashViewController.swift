//
//  SplashViewController.swift
//  Firebase Example
//
//  Created by Adolfo Lozano Mendez on 13/03/18.
//  Copyright © 2018 Adolfo Lozano Mendez. All rights reserved.
//

import UIKit
import FirebaseAuth

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if(user != nil) {
                self.navigateToMain()
            } else {
                self.navigateToLogin()
            }
        }
    }
    
    func navigateToLogin(){
        print("showLoginSegue")
        performSegue(withIdentifier: "showLoginSegue", sender: nil)
    }
    
    func navigateToMain(){
        print("showMainSegue")
        performSegue(withIdentifier: "showMainSegue", sender: nil)
    }

}
