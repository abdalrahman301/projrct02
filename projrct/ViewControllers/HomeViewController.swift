//
//  HomeViewController.swift
//  projrct
//
//  Created by htu on 7/28/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    
    @IBOutlet weak var Welcome: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    setUpElements()
    }
    
    func setUpElements() {
        Utilities.styleLabel(Welcome)
    }
  

}
