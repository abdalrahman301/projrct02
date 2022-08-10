//
//  LogInViewController.swift
//  projrct
//
//  Created by htu on 7/28/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit

import FirebaseAuth

class LogInViewController: UIViewController {
    
    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var PasswordTxt: UITextField!
    @IBOutlet weak var LogInButton: UIButton!

    @IBOutlet weak var errlbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
setUpElements()
        
    }
    
    func setUpElements() {
        
        errlbl.alpha = 0
        Utilities.styleTextField(EmailTxt)
        Utilities.styleTextField(PasswordTxt)
        Utilities.styleFilledButton(LogInButton)
        
        
        
    }
   
          
        
        
       
    
    
    
    
    
    
    

    
    @IBAction func LogInClicked(_ sender: Any) {
        
        let email = EmailTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = PasswordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard let _ = result?.user, error == nil else {
                        self.errlbl.alpha = 1
                        self.errlbl.text = (error?.localizedDescription)
                        print (error!.localizedDescription)
                        return
                    }
                
                    let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.TabViewController) as? CustomTabBarController
                    
                    self.view.window?.rootViewController = homeViewController
                    self.view.window?.makeKeyAndVisible()
                   
                
                
                
            
        
        
}
    
}
}
