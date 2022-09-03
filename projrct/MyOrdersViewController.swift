//
//  MyOrdersViewController.swift
//  projrct
//
//  Created by htu on 8/11/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class MyOrdersViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ordersArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTableView.dequeueReusableCell(withIdentifier: "ordersCell") as! OrdersTableViewCell
        cell.orderAdress.text = ordersArr[indexPath.row].orderadress
    
        cell.orderDate.text = ordersArr[indexPath.row].orderdate
        cell.orderPrice.text = "\(ordersArr[indexPath.row].orderprice) Jd"
        if cell.orderStatus.text == "Delieverd!" {
             cell.orderStatus.textColor = UIColor.init(red: 58/255, green: 99/255, blue: 88/255, alpha: 1)
            cell.orderStatus.text = ordersArr[indexPath.row].orderstatus
           
        } else {
cell.orderStatus.text = ordersArr[indexPath.row].orderstatus
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    
    
    @IBOutlet weak var ordersTableView: UITableView!
    var ordersArr = [orderData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersTableView.dataSource = self
        ordersTableView.delegate = self
                    guard let userId = Auth.auth().currentUser?.uid else {return}
             //print(userId)
             let db = Firestore.firestore()
             

        db.collection("orders").whereField("uid", isEqualTo: userId)
            .getDocuments() {[weak self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                     let status = document.data()["status"] as? String
                     let adress = document.data()["Adress"] as? String
                        let price = document.data()["price"] as? Double
                        let date = document.data()["date"] as? String
                        //print(document.data())
                       
                        let doc = orderData(oStatus: status ?? "", oPrice: price ?? 0.0, oDate: date ?? "", oAdress: adress ?? "")
                       
                        self?.ordersArr.append(doc)
                        //let Myindex = IndexPath(row: (self?.arr.count)!-1, section: 0)
                        //self?.cartTableView.beginUpdates()
                        //self?.cartTableView.insertRows(at: [Myindex], with: .top)
                        //self?.cartTableView.endUpdates()
                        self?.ordersTableView.reloadData()

                    
                    }
                }
               // self?.cartTableView.reloadData()
                
                
        }
        
        
    }
    

   

}
