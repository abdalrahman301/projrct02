//
//  LogInViewController.swift
//  projrct
//
//  Created by htu on 7/28/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var PasswordTxt: UITextField!
    @IBOutlet weak var LogInButton: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
setUpElements()
        
    }
    
    func setUpElements() {
        
        // Hide the error label
        
        
        // Style the elements
        Utilities.styleTextField(EmailTxt)
        Utilities.styleTextField(PasswordTxt)
        Utilities.styleFilledButton(LogInButton)
        
        
        
    }
    @IBAction func LogInClicked(_ sender: Any) {
    }
    
 

}
