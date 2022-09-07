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
import PassKit
import StoreKit

class CheckOutViewController: UIViewController {

    
    @IBOutlet weak var adress: UITextField!
    
    
    @IBOutlet weak var phone: UITextField!
    
    
    @IBOutlet weak var payment: UITextField!
    let cities = ["Amman","Salt","Madaba","Irbid","Ajloun","Jerash","Aqaba","Alkarak","Almafraq"]
    //let payments = ["Cash on delivery","Apple Pay"]
    
    @IBOutlet weak var showtotal: UILabel!
    
    
    @IBOutlet weak var checkbutton: UIButton!
    
    
    @IBOutlet weak var apple: UIButton!
    
    
    
    
    var pickerview = UIPickerView()
    var totalrecieved = 0.0
    var discount = false
    
    @IBOutlet weak var discountLabel: UILabel!
   
                            
    
    var discountvalue  = 0.0
    
    @IBOutlet weak var totalLabel: UILabel!
    var total = 0.0
    var tax = 1.2
    
      private var paymentrequest : PKPaymentRequest = {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant."
        request.supportedNetworks = [.quicPay , .masterCard , .visa]
        request.supportedCountries = ["JO"]
        
        request.merchantCapabilities = .capability3DS
        request.countryCode = "JO"
        request.currencyCode = "JOD"
        var total = 0.0
        
        //request.paymentSummaryItems = [PKPaymentSummaryItem(label: "perfumes", amount:)]
        return request
    }()
    //let protocolID = "merchant."
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleFilledButton(checkbutton)
        Utilities.styleFilledButton(apple)
        self.apple.addTarget(self, action: #selector(tapForPay), for: .touchUpInside)
        //checkbutton.isEnabled = false
       
        guard let userId = Auth.auth().currentUser?.uid else {return}
         let db = Firestore.firestore()
                    

               db.collection("discount").whereField("uid", isEqualTo: userId)
                   .getDocuments() { (querySnapshot, err) in
                       if let err = err {
                           print("Error getting documents: \(err)")
                       } else {
                        for document in querySnapshot!.documents {
                           let yes = document.data()["discount"] as? Bool
                            if yes == true {
                                self.discountLabel.text = "Discount : 3.5 Jd"
                                self.discountvalue = 3.5
                            }else {
                                self.discountvalue = 0.0
                                
                            }
                        }
                    }
        }
        
        discountvalue = 3.5
        total = totalrecieved + tax - discountvalue
        showtotal.text = "price of products : \(totalrecieved) Jd"
        //discountLabel.text = "Discount : \(discountvalue) Jd"
        totalLabel.text = "Total : \(total) Jd"
        paymentrequest.paymentSummaryItems = [PKPaymentSummaryItem(label: "perfumes", amount: NSDecimalNumber(value: total))]
        pickerview.dataSource = self
        pickerview.delegate = self
        adress.inputView = pickerview
        //payment.inputView = pickerview
        adress.textAlignment = .center
        //payment.textAlignment = .center
       // SKPaymentQueue.default().add(self)//
       
        
    }
    @objc func tapForPay() {
       
         if adress.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || phone.text?.trimmingCharacters(in: .whitespacesAndNewlines ) == "" || total == 0.0 {
                   let showerrorSent = UIAlertController(title: "error!", message: "You have to fill all blanks!", preferredStyle: .alert)
                   showerrorSent.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   self.present(showerrorSent, animated: true, completion: nil)
               }else {
              let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentrequest)
            if controller != nil  {
                      controller!.delegate = self
                      present(controller! , animated: true ){
                    
                        print("completed")
                        
                        
                           
                  }
                
               
                }
          }
        
        
      
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
            "payment" : "notyet",
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


extension CheckOutViewController:UIPickerViewDataSource ,UIPickerViewDelegate ,PKPaymentAuthorizationViewControllerDelegate  {
 
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
        print ("done")
         let date = Date().addingTimeInterval(10)
                             let dateComponents = Calendar.current.dateComponents([.year , .month , .day], from: date)
               let currentdate = "\(dateComponents.year!)/\(dateComponents.month!)/\(dateComponents.day!)"
          guard let userId = Auth.auth().currentUser?.uid else {return}
                                                    let db = Firestore.firestore()
                                                    var ref: DocumentReference? = nil
                                                    ref = db.collection("orders").addDocument(data: [
                                                        "uid" : userId,
                                                        "Adress" : self.adress.text!,
                                                        "phone" : self.phone.text!,
                                                      "status" : "Progress..",
                                                      "date" : currentdate,
                                                      "payment" : "applepay",
                                                      "price" : self.total
                                                        
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
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        
    }

    
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

  


