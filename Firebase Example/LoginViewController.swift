//
//  LoginViewController.swift
//  Firebase Example
//
//  Created by Adolfo Lozano Mendez on 5/03/18.
//  Copyright © 2018 Adolfo Lozano Mendez. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var edtUserName: UITextField!
    @IBOutlet weak var edtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogInClicked(_ sender: Any) {
        Auth.auth().signIn(withEmail: edtUserName.text!, password: edtPassword.text!) { (user, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "toOpenMain", sender: nil)
            }
        }
        
    }
    
    @IBAction func onRegisterClicked(_ sender: Any) {
        Auth.auth().createUser(withEmail: edtUserName.text!, password: edtPassword.text! ){ (user, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "toOpenMain", sender: nil)
            }
        }
    }
}
