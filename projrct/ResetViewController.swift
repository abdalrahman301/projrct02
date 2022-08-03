//
//  ResetViewController.swift
//  projrct
//
//  Created by htu on 8/3/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit

class ResetViewController: UIViewController {
    
    @IBOutlet weak var ConfirmButton: UIButton!
    @IBOutlet weak var TextCode: UITextField!
    @IBOutlet weak var CheckButton: UIButton!
    @IBOutlet weak var Passtxtnew: UITextField!
    @IBOutlet weak var repasstxtnew: UITextField!
    @IBOutlet weak var ResetButton: UIButton!
    
    @IBOutlet weak var labelone: UILabel!
    @IBOutlet weak var labeltwo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
setUpElements()
        
       
    }
    func setUpElements () {
        labelone.alpha = 0
        labeltwo.alpha = 0
        TextCode.alpha = 0
        CheckButton.alpha = 0
       Passtxtnew.alpha = 0
        repasstxtnew.alpha = 0
        ResetButton.alpha = 0
        
        Utilities.styleHollowButton(ConfirmButton)
        Utilities.styleHollowButton(CheckButton)
        Utilities.styleHollowButton(ResetButton)
        Utilities.styleTextField(TextCode)
        Utilities.styleTextField(Passtxtnew)
        Utilities.styleTextField(repasstxtnew)
        }

 
    @IBAction func confirmButtonclick(_ sender: Any) {
        labelone.alpha = 1
        TextCode.alpha = 1
        CheckButton.alpha = 1
    }
    
    @IBAction func checkButtonClick(_ sender: Any) {
        labeltwo.alpha = 1
        Passtxtnew.alpha = 1
        repasstxtnew.alpha = 1
        ResetButton.alpha = 1
    }
    
    @IBAction func resetButtonClick(_ sender: Any) {
    }
    
    
    
}
