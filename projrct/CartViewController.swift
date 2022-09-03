//
//  CartViewController.swift
//  projrct
//
//  Created by htu on 8/23/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAnalytics
import FirebaseAuth
import FirebaseCore

class CartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = cartTableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        cell.imageproduct.image = UIImage(named: arr[indexPath.row].CartImage) ?? UIImage(named: "help")
        cell.nameproduct.text = arr[indexPath.row].CartName
        cell.numberproduct.text = ("\(arr[indexPath.row].CartNumber)X")
        cell.priceproduct.text = "\(arr[indexPath.row].CartPrice) Jd"
        //tableView.reloadData()
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.borderWidth = 0.5
           return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, complete in
             
            self.arr.remove(at: indexPath.row)
             //reload the table to avoid index out of bounds crash..
            self.cartTableView.deleteRows(at: [indexPath], with: .automatic)
            
             complete(true)
         }
         
         
         let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
         configuration.performsFirstActionWithFullSwipe = true
            //self.cartTableView.reloadData()
         return configuration
     }
    
    
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var checkOut: UIButton!
    var imagecartrecieved = UIImage()
    //var pricecartrecieved = ""
    //var numbercartrecieved = ""
    //var namecartrecieved = ""
    
    var arr = [CartData]()
    var send = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleFilledButton(checkOut)
       // cartTableView.rowHeight = UITableView.automaticDimension;
       // cartTableView.estimatedRowHeight = 60.0;
      
        cartTableView.dataSource = self
        cartTableView.delegate = self
        //cartTableView.reloadData()
        
                              guard let userId = Auth.auth().currentUser?.uid else {return}
             //print(userId)
             let db = Firestore.firestore()
             

        db.collection("cart").whereField("uid", isEqualTo: userId)
            .getDocuments() {[weak self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                     let name = document.data()["name"] as? String
                     let image = document.data()["image"] as? String
                        let price = document.data()["price"] as? Double
                        let number = document.data()["number"] as? Double
                        //print(document.data())
                       
                        let doc = CartData(CName: name ?? "", CImg: image ?? "", CPrc: price ?? 0 , CNmbr: number ?? 0)
                       
                        self?.arr.append(doc)
                        //let Myindex = IndexPath(row: (self?.arr.count)!-1, section: 0)
                        //self?.cartTableView.beginUpdates()
                        //self?.cartTableView.insertRows(at: [Myindex], with: .top)
                        //self?.cartTableView.endUpdates()
                        self?.cartTableView.reloadData()

                    
                    }
                }
               // self?.cartTableView.reloadData()
                
                
        }
        
        
       
        

    }

    
    @IBAction func orderclicked(_ sender: Any) {
        
        for ar in self.arr {
            print(ar.CartPrice)
            self.send += ar.CartPrice
            
        }
        
        let checkViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.CheckOutViewController) as? CheckOutViewController
        checkViewController?.totalrecieved = self.send
        
        self.present(checkViewController! , animated: true)
        
        self.send = 0.0
        
        
        
    }
    

}
