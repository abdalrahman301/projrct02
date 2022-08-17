//
//  ProfileViewController.swift
//  projrct
//
//  Created by htu on 8/11/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit
import FirebaseAuth

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

    @IBAction func logoutpressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
            let VCViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.Viewcontroller) as? ViewController
            
            self.view.window?.rootViewController = VCViewController
            self.view.window?.makeKeyAndVisible()
            
            
            } catch let err {
                let errAlertSent = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                                  errAlertSent.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                  self.present(errAlertSent, animated: true, completion: nil)
        }
    }
    

}
