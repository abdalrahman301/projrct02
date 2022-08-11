//
//  DiscountViewController.swift
//  projrct
//
//  Created by htu on 8/11/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit

class DiscountViewController: UIViewController {
    
    
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
  

}
