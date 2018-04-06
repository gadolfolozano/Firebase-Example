//
//  FirstViewController.swift
//  Firebase Example
//
//  Created by Adolfo Lozano Mendez on 5/03/18.
//  Copyright © 2018 Adolfo Lozano Mendez. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var imagesUrlArray = [String]()
    
    @IBOutlet weak var mTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTableView.delegate = self
        mTableView.dataSource = self
        
        retrieveData()
    }
    
    func retrieveData(){
        
        self.imagesUrlArray.removeAll(keepingCapacity: false)
        
        let ref = Database.database().reference()
        ref.child("posts").observe(DataEventType.value, with: { (snapshot) in
            //let value = snapshot.value as? NSDictionary
            //let imageURL = value?["imageURL"] as? String ?? ""
            for child in snapshot.children {
                let value = (child as? DataSnapshot)?.value as? NSDictionary
                let imageURL = value?["imageURL"] as? String ?? ""
                self.imagesUrlArray.append(imageURL)
                
                self.mTableView.reloadData()
            }
        })
    }
    
    //get count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesUrlArray.count
    }
    
    //bind
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = imagesUrlArray[indexPath.row]
        return cell
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

