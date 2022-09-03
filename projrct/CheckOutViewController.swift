//
//  CheckOutViewController.swift
//  projrct
//
//  Created by htu on 8/24/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth

class CheckOutViewController: UIViewController {

    
    @IBOutlet weak var adress: UITextField!
    
    
    @IBOutlet weak var phone: UITextField!
    
    
    @IBOutlet weak var payment: UITextField!
    let cities = ["Amman","Salt","Madaba","Irbid","Ajloun","Jerash","Aqaba","Alkarak","Almafraq"]
    //let payments = ["Cash on delivery","Apple Pay"]
    
    @IBOutlet weak var showtotal: UILabel!
    
    
    @IBOutlet weak var checkbutton: UIButton!
    
    
    var pickerview = UIPickerView()
    var totalrecieved = 0.0
    var discount = false
    
    @IBOutlet weak var discountLabel: UILabel!
    var discountvalue  = 0.0
    
    @IBOutlet weak var totalLabel: UILabel!
    var total = 0.0
    var tax = 1.2
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleFilledButton(checkbutton)
        //checkbutton.isEnabled = false
        if discount == true {
            discountvalue = 3.5
              discountLabel.text = "Discount : \(discountvalue) Jd"
        }else {
            discountvalue = 0.0
              discountLabel.text = "Discount : \(discountvalue) Jd"
        }
        total = totalrecieved + tax - discountvalue
        showtotal.text = "price of products : \(totalrecieved) Jd"
        //discountLabel.text = "Discount : \(discountvalue) Jd"
        totalLabel.text = "Total : \(total) Jd"
        pickerview.dataSource = self
        pickerview.delegate = self
        adress.inputView = pickerview
        //payment.inputView = pickerview
        adress.textAlignment = .center
        //payment.textAlignment = .center
       
      
        
    }
    
    
    @IBAction func checkclicked(_ sender: Any) {
         let date = Date().addingTimeInterval(10)
                      let dateComponents = Calendar.current.dateComponents([.year , .month , .day], from: date)
        let currentdate = "\(dateComponents.year!)/\(dateComponents.month!)/\(dateComponents.day!)"
         if adress.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || phone.text?.trimmingCharacters(in: .whitespacesAndNewlines ) == "" || total == 0.0 {
                   let showerrorSent = UIAlertController(title: "error!", message: "You have to fill all blanks!", preferredStyle: .alert)
                   showerrorSent.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   self.present(showerrorSent, animated: true, completion: nil)
               }else {
                   
        
        guard let userId = Auth.auth().currentUser?.uid else {return}
          let db = Firestore.firestore()
          var ref: DocumentReference? = nil
          ref = db.collection("orders").addDocument(data: [
              "uid" : userId,
              "Adress" : adress.text!,
            "phone" : phone.text!,
            "status" : "Progress..",
            "date" : currentdate,
            "price" : total
              
          ]) { err in
              if let err = err {
                  print("Error adding document: \(err)")
              } else {
                  
                  print("Document added with ID: \(ref!.documentID)")
                  let showAddedSent = UIAlertController(title: "success!", message: "Your order has been successfully added we will contact you soon.Thank you for ordering!", preferredStyle: .alert)
                  showAddedSent.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                  self.present(showAddedSent, animated: true, completion: nil)
                self.total = 0.0
                self.discountvalue = 0.0
                self.phone.text = ""
                self.adress.text = ""
            
                 db.collection("cart").whereField("uid", isEqualTo: userId).getDocuments { (querySnapshot, error) in
                                            if error != nil {
                                                print(error?.localizedDescription ?? "something wrong")
                                            } else {
                                                for document in querySnapshot!.documents {
                                                    document.reference.delete()
                                                }
                                    
                                            }
                                        }
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.TabViewController) as? CustomTabBarController
                           
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
                
              }
          }
        
        
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

  


