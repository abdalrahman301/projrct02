//
//  CheckOutViewController.swift
//  projrct
//
//  Created by htu on 8/24/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit

class CheckOutViewController: UIViewController {

    
    @IBOutlet weak var adress: UITextField!
    
    
    @IBOutlet weak var phone: UIStackView!
    
    
    @IBOutlet weak var payment: UITextField!
    let cities = ["Amman","Salt","Madaba","Irbid","Ajloun","Jerash","Aqaba","Alkarak","Almafraq"]
    //let payments = ["Cash on delivery","Apple Pay"]
    
    var pickerview = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerview.dataSource = self
        pickerview.delegate = self
        adress.inputView = pickerview
        //payment.inputView = pickerview
        adress.textAlignment = .center
        //payment.textAlignment = .center
        
    }
    
}
extension CheckOutViewController:UIPickerViewDataSource ,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        adress.text = cities[row]
        adress.resignFirstResponder()
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
        
    }

  


