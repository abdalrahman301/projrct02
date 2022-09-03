//
//  AccountViewController.swift
//  projrct
//
//  Created by htu on 8/10/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore
import FirebaseAnalytics

class AccountViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AccountList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyFirstTableViewCell
        cell.imgtable.image = UIImage(named:AccountList[indexPath.row].AccountImage)
        cell.labeltabel.text = AccountList[indexPath.row].AccountName
                             
    return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
           
            let next = self.storyboard?.instantiateViewController(withIdentifier: "profileVC") as! ProfileViewController
            self.present(next, animated: true, completion: nil)
            
        }else if indexPath.row == 2{
             let next = self.storyboard?.instantiateViewController(withIdentifier: "ordersVC") as! MyOrdersViewController
                       self.present(next, animated: true, completion: nil)
        }else if indexPath.row == 3 {
             let next = self.storyboard?.instantiateViewController(withIdentifier: "discountVC") as! DiscountViewController
                       self.present(next, animated: true, completion: nil)
        }else if indexPath.row == 5 {
          
                guard let userId = Auth.auth().currentUser?.uid else {return}
                  let db = Firestore.firestore()
                 db.collection("cart").whereField("uid", isEqualTo: userId).getDocuments { (querySnapshot, error) in
                        if error != nil {
                            print(error?.localizedDescription ?? "something wrong")
                        } else {
                            for document in querySnapshot!.documents {
                                document.reference.delete()
                            }
                
                        }
                    }
                
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
        } else if indexPath.row == 1 {
             let next = self.storyboard?.instantiateViewController(withIdentifier: "favouriteVC") as! FavouriteViewController
                                  self.present(next, animated: true, completion: nil)
        }
            
        else {
            let showAboutSent = UIAlertController(title: "About!", message: "You can know more about us if you visit our website www.perfumeworld.com ", preferredStyle: .alert)
            showAboutSent.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(showAboutSent, animated: true, completion: nil)
        }
    }
    
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 90
      }
      func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
          return 50
      }
    

    @IBOutlet weak var Accountname: UILabel!
    
    @IBOutlet weak var MyTableView: UITableView!
    
    var AccountList = [AccountData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
filldata()
        MyTableView.delegate = self
        MyTableView.dataSource = self
                            guard let userId = Auth.auth().currentUser?.uid else {return}
             //print(userId)
             let db = Firestore.firestore()
             

        db.collection("users").whereField("uid", isEqualTo: userId)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                     let first = document.data()["firstname"] as? String
                     let last = document.data()["lastname"] as? String
                     let fullusername = (first! + " " + last!)
                        self.Accountname.text = fullusername
                       
                        
                    }
                }
        }

    }
    
    func filldata () {
       let account1 = AccountData(AName: "Profile", AImg: "profile")
        AccountList.append(account1)
        let account2 = AccountData(AName: "Favourites" , AImg: "fav")
        AccountList.append(account2)
         let account3 = AccountData(AName: "My Orders", AImg: "orders")
        AccountList.append(account3)
         let account4 = AccountData(AName: "Codes", AImg: "discount")
               AccountList.append(account4)
         let account5 = AccountData(AName: "Help", AImg: "help")
               AccountList.append(account5)
        let account6 = AccountData(AName: "Log out", AImg: "logout")
        AccountList.append(account6)
    }
    
}
