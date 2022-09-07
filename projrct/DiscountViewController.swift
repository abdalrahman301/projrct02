//
//  DiscountViewController.swift
//  projrct
//
//  Created by htu on 8/11/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class DiscountViewController: UIViewController {
    let code = "ABd11"
   
    var iftrue = false
    @IBOutlet weak var theCode: UITextField!
    

    @IBOutlet weak var goButton: UIButton!
    
    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setUpElements()
        //Confirm()
 
        
        
    }
   
   
    
    func setUpElements () {
        Utilities.styleTextField(theCode)
        Utilities.styleHollowButton(goButton)
        label.alpha = 0 
    }
  
    @IBAction func Confirm(_ sender: Any) {
        if theCode.text == code {
            var ref : DocumentReference? = nil
        guard let userId = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore()
        ref = db.collection("discount").addDocument(data: ["uid":userId, "discount":true]) { (error) in
             if let error = error {
                           print("Error adding document: \(error)")
                       } else {
                           
                           print("Document added with ID: \(ref!.documentID)")
                           let showAddedSent = UIAlertController(title: "Wow!", message: "Go and enjoy your discount", preferredStyle: .alert)
                           showAddedSent.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                           self.present(showAddedSent, animated: true, completion: nil)
                       }
            }
        }
    }
    
}
