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
   
    var iftrue = false
    @IBOutlet weak var theCode: UITextField!
    

    @IBOutlet weak var goButton: UIButton!
    
    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setUpElements()
        //Confirm()
        var discount = 0.0
                if theCode.text == code {
             discount = 3.5
              goButton.isEnabled = false
                                label.alpha = 1
                   let VCViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.CheckOutViewController) as? CheckOutViewController
                    VCViewController?.discountvalue = discount
                  //  present(VCViewController! ,animated: true)
             
             
         }else {
             discount = 0.0
            
                
        
         }

        print(discount)
        
        
    }
   
   
    
    func setUpElements () {
        Utilities.styleTextField(theCode)
        Utilities.styleHollowButton(goButton)
        label.alpha = 0 
    }
  
    @IBAction func Confirm(_ sender: Any) {
        viewDidLoad()
        
    }
    
}
