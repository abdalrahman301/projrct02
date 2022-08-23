//
//  ResetViewController.swift
//  projrct
//
//  Created by htu on 8/3/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ResetViewController: UIViewController {
    
    @IBOutlet weak var ConfirmButton: UIButton!

    
    @IBOutlet weak var myEmail: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
setUpElements()
        
       
    }
    func setUpElements () {
    
        
        Utilities.styleHollowButton(ConfirmButton)
        Utilities.styleTextField(myEmail)
        }

 
    @IBAction func confirmButtonclick(_ sender: Any) {
      
        Auth.auth().sendPasswordReset(withEmail: myEmail.text!) { error in
            DispatchQueue.main.async {
                if self.myEmail.text?.isEmpty==true || error != nil {
                    let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetFailedAlert, animated: true, completion: nil)
                }
                if error == nil && self.myEmail.text?.isEmpty==false{
                    let resetEmailAlertSent = UIAlertController(title: "Reset Email Sent", message: "Reset email has been sent to your login email, please follow the instructions in the mail to reset your password", preferredStyle: .alert)
                    resetEmailAlertSent.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetEmailAlertSent, animated: true, completion: nil)
                }
            }
        }
        
        
        
    }
    
  
    
    
    
}
