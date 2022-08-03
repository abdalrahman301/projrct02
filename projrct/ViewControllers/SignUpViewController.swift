//
//  SignUpViewController.swift
//  projrct
//
//  Created by htu on 7/28/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var FirstNametxt: UITextField!
    
    @IBOutlet weak var LastNametxt: UITextField!
    
    @IBOutlet weak var Emailtxt: UITextField!
    
    @IBOutlet weak var PhoneNumbertxt: UITextField!
    
    @IBOutlet weak var Passwordtxt: UITextField!
    
    @IBOutlet weak var Repasswordtxt: UITextField!
    
    @IBOutlet weak var SignUpButton: UIButton!
   
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    func setUpElements() {
         // Hide the error label
               
               
               // Style the elements
               Utilities.styleTextField(FirstNametxt)
               Utilities.styleTextField(LastNametxt)
               Utilities.styleTextField(Emailtxt)
               Utilities.styleTextField(PhoneNumbertxt)
               Utilities.styleTextField(Passwordtxt)
               Utilities.styleTextField(Repasswordtxt)
               Utilities.styleFilledButton(SignUpButton)
            
        
    }
    
    @IBAction func SignUpClicked(_ sender: Any) {
    }
    


}
