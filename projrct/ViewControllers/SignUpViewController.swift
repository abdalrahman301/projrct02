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
    @IBOutlet weak var Errorlbl: UILabel!
    
    @IBOutlet weak var Pagesignup: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    func setUpElements() {
         // Hide the error label
               Errorlbl.alpha = 0
               
               // Style the elements
               Utilities.styleTextField(FirstNametxt)
               Utilities.styleTextField(LastNametxt)
               Utilities.styleTextField(Emailtxt)
               Utilities.styleTextField(PhoneNumbertxt)
               Utilities.styleTextField(Passwordtxt)
               Utilities.styleTextField(Repasswordtxt)
               Utilities.styleFilledButton(SignUpButton)
               Utilities.styleLabel(Pagesignup)
        
    }
    
    @IBAction func SignUpClicked(_ sender: Any) {
    }
    


}
