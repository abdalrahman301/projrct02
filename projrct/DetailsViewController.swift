//
//  DetailsViewController.swift
//  projrct
//
//  Created by htu on 8/17/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var passedimage: UIImageView!
    var imagerecieved = UIImage()
    
    
    @IBOutlet weak var passedname: UILabel!
    var namerecieved = ""
    
    @IBOutlet weak var paseedprice: UILabel!
    var pricerecieved = ""
    
    @IBOutlet weak var addtocart: UIButton!
    
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var numberlabel: UILabel!
    
    
    @IBOutlet weak var passeddescreption: UILabel!
    var descrecieved = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleFilledButton(addtocart)
        passedimage.image = imagerecieved
        passedname.text = namerecieved
        paseedprice.text = pricerecieved
        passeddescreption.text = descrecieved
         stepper.wraps = true
         stepper.autorepeat = true
         stepper.maximumValue = 10
        stepper.minimumValue = 1
      
    }
    
    @IBAction func stepperchange(_ sender: UIStepper) {
        numberlabel.text = Int(sender.value).description
    }
    

    @IBAction func AddButton(_ sender: Any) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "CheckVC") as! CheckOutViewController
        self.present(next, animated: true, completion: nil)
        
    }
    
    

}