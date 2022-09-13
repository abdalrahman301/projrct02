//
//  SignUpViewController.swift
//  projrct
//
//  Created by htu on 7/28/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
var dd = false
class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var FirstNametxt: UITextField!
    
    @IBOutlet weak var LastNametxt: UITextField!
    
    @IBOutlet weak var Emailtxt: UITextField!
    
    
    @IBOutlet weak var Passwordtxt: UITextField!
    
    
    @IBOutlet weak var SignUpButton: UIButton!
   
    
    @IBOutlet weak var errlabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    func setUpElements() {
        
               
               
        errlabel.alpha = 0
               Utilities.styleTextField(FirstNametxt)
               Utilities.styleTextField(LastNametxt)
               Utilities.styleTextField(Emailtxt)
               Utilities.styleTextField(Passwordtxt)
               Utilities.styleFilledButton(SignUpButton)
            
        
    }
    
    
    func validateFields() -> String? {
        
        
        if FirstNametxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            LastNametxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            Emailtxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            Passwordtxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            dd = true
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = Passwordtxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }else {
        
            return nil }
    }
    
     
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func SignUpClicked(_ sender: Any) {
        
        
       
        
        
        
        
        

       let error = validateFields()
            
            if error != nil {
                if dd == true {
                errlabel.alpha = 1
                    errlabel.text = "fill all blanks"
                    dd = false
                }
                else {
                    errlabel.alpha = 1
                    errlabel.text = "Please make sure your password is at least 8 characters, contains a special character and a number."
                    
                }
                
            }
            else {
                
                
                let firstName = FirstNametxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let lastName = LastNametxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let email = Emailtxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = Passwordtxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
               
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    guard let user = result?.user, error == nil else {
                        self.errlabel.alpha = 1
                        self.errlabel.text = (error?.localizedDescription)
                        print (error!.localizedDescription)
                        return
                    }
                
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.errlabel.text = "Error saving user data"
                            
                        }else {
                            var user = firstName + lastName
                            
                        }
                    }
                    
                    
                    
                  
                 
                transitionToHome()
                  
                
                
                
            
        }
        
        func showError(_ message:String) {
            
            errlabel.text = message
            errlabel.alpha = 1
        }
        
        func transitionToHome() {
            
            let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.TabViewController) as? CustomTabBarController
            
            view.window?.rootViewController = homeViewController
            view.window?.makeKeyAndVisible()
            
        }
        
        
        
        
        
        
        
        
        
    }
    


}
}
