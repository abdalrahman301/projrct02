//
//  ViewController.swift
//  projrct
//
//  Created by htu on 7/28/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var SignButton: UIButton!
    
    
    @IBOutlet weak var LogButton: UIButton!
    
    
    @IBOutlet weak var SkipButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       setUpElements()
        
    }
    
    
     func setUpElements() {
           
           Utilities.styleFilledButton(SignButton)
           Utilities.styleHollowButton(LogButton)
        Utilities.styleFilledButton(SkipButton)
           
       }
  
   }

    




