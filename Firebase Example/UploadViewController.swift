//
//  SecondViewController.swift
//  Firebase Example
//
//  Created by Adolfo Lozano Mendez on 5/03/18.
//  Copyright © 2018 Adolfo Lozano Mendez. All rights reserved.
//

import UIKit
import FirebaseAuth

class UploadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onLogOutClicked(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
            let loginSB = self.storyboard?.instantiateViewController(withIdentifier: "loginStoryBoard") as! LoginViewController
            let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
            delegate.window?.rootViewController = loginSB
            
        } catch let signOutError as NSError {
            let alert = UIAlertController(title: "Error", message: signOutError.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

