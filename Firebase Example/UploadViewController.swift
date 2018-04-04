//
//  SecondViewController.swift
//  Firebase Example
//
//  Created by Adolfo Lozano Mendez on 5/03/18.
//  Copyright © 2018 Adolfo Lozano Mendez. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class UploadViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {

    @IBOutlet weak var mImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mImageView.isUserInteractionEnabled = true
        let gestureReconizer = UITapGestureRecognizer(target: self, action: #selector(UploadViewController.selectImage))
        mImageView.addGestureRecognizer(gestureReconizer)
    }
    
    @objc func selectImage(){
        print("selectImge")
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        mImageView.image = chosenImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPostClicked(_ sender: Any) {
        let ref = Database.database().reference()
        let currentUser = Auth.auth().currentUser
        
        ref.child("users").child((currentUser?.uid)!).updateChildValues(["email": currentUser?.email ?? "noEmail"])
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let uuidPost = ref.child("posts").childByAutoId().key
        
        // Create a reference to 'images/userid/uuid.jpg'
        let mountainImagesRef = storageRef.child("images/\(currentUser?.uid ?? "noUserId")/\(uuidPost).jpg")
        let data = UIImageJPEGRepresentation(mImageView.image!, 0.5)
        
        
        // Upload the file to the path "images/userid/uuid.jpg"
        _ = mountainImagesRef.putData(data!, metadata: nil) { (metadata, error) in
            if(error != nil) {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.mImageView.image = UIImage(named: "ic_choose_gallery.png")
                self.tabBarController?.selectedIndex = 0
                
                
                let imageURL = metadata?.downloadURL()?.absoluteString
                
                ref.child("posts").child(uuidPost)
                    .setValue(["imageURL": imageURL, "user": currentUser?.email])
                ref.child("users").child((currentUser?.uid)!).child("posts").child(uuidPost)
                    .setValue(["imageURL": imageURL, "user": currentUser?.email])
                
            }
        }
        
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

