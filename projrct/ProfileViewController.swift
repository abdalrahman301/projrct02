//
//  ProfileViewController.swift
//  projrct
//
//  Created by htu on 8/11/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var editButton: UIButton!
    
    
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
setUpElements()
        
    }
    func setUpElements() {
        Utilities.styleHollowButton(editButton)
        Utilities.styleFilledButton(logoutButton)
    }

  

}
