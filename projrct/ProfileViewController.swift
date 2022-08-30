//
//  ProfileViewController.swift
//  projrct
//
//  Created by htu on 8/11/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {


    
    @IBOutlet weak var Username: UILabel!
    
    
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
setUpElements()
                              guard let userId = Auth.auth().currentUser?.uid else {return}
             //print(userId)
             let db = Firestore.firestore()
             

        db.collection("users").whereField("uid", isEqualTo: userId)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                     let first = document.data()["firstname"] as? String
                     let last = document.data()["lastname"] as? String
                     let fullusername = (first! + " " + last!)
                        self.Username.text = fullusername
                    }
                }
        }
    }
    func setUpElements() {
        
        Utilities.styleFilledButton(logoutButton)
        
        
        
    }

    @IBAction func logoutpressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
            let VCViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.Viewcontroller) as? ViewController
            
            self.view.window?.rootViewController = VCViewController
            self.view.window?.makeKeyAndVisible()
            
            
            } catch let err {
                let errAlertSent = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                                  errAlertSent.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                  self.present(errAlertSent, animated: true, completion: nil)
        }
    }
    

    

}
