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
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var postArray = [Post]()
    
    @IBOutlet weak var mTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTableView.delegate = self
        mTableView.dataSource = self
        
        retrieveData()
    }
    
    func retrieveData(){
        
        self.postArray.removeAll(keepingCapacity: false)
        
        let ref = Database.database().reference()
        ref.child("posts").observe(DataEventType.value, with: { (snapshot) in
            //let value = snapshot.value as? NSDictionary
            //let imageURL = value?["imageURL"] as? String ?? ""
            for child in snapshot.children {
                let value = (child as? DataSnapshot)?.value as? NSDictionary
                let post = Post()
                post.urlImage = value?["imageURL"] as? String ?? ""
                post.userName = value?["user"] as? String ?? ""
                self.postArray.append(post)
                
                self.mTableView.reloadData()
            }
        })
    }
    
    //get count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    //bind
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellViewTable
        
        cell.mUserName.text = self.postArray[indexPath.row].userName
        
        cell.mImageView.sd_setImage(with: URL(string: self.postArray[indexPath.row].urlImage))
        
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

