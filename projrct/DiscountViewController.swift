//
//  DiscountViewController.swift
//  projrct
//
//  Created by htu on 8/11/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit

class DiscountViewController: UIViewController {
    let code = "ABd11"
    var discount = true
    @IBOutlet weak var theCode: UITextField!
    

    @IBOutlet weak var goButton: UIButton!
    
    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setUpElements()
    }
    
    func setUpElements () {
        Utilities.styleTextField(theCode)
        Utilities.styleHollowButton(goButton)
        label.alpha = 0 
    }
  
    @IBAction func Confirm(_ sender: Any) {
        if theCode.text == code {
            discount = true
            let VCViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.CheckOutViewController) as? CheckOutViewController
            VCViewController?.discount = discount
            goButton.isEnabled = false
            label.alpha = 1
        }else {
         let showTryAgainSent = UIAlertController(title: "Wrong code!", message: "Wrong code try agailn later  ", preferredStyle: .alert)
                   showTryAgainSent.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   self.present(showTryAgainSent, animated: true, completion: nil)
        }
        
    }
    
}
