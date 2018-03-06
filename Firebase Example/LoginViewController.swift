//
//  LoginViewController.swift
//  Firebase Example
//
//  Created by Adolfo Lozano Mendez on 5/03/18.
//  Copyright © 2018 Adolfo Lozano Mendez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogInClicked(_ sender: Any) {
        performSegue(withIdentifier: "toOpenMain", sender: nil)
    }
    
    @IBAction func onRegisterClicked(_ sender: Any) {
        performSegue(withIdentifier: "toOpenMain", sender: nil)
    }
}
