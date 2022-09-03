//
//  FavouriteViewController.swift
//  projrct
//
//  Created by htu on 9/2/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseAnalytics
import FirebaseFirestore

class FavouriteViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mytableview.dequeueReusableCell(withIdentifier: "favcell", for: indexPath) as! FavouriteTableViewCell
        cell.favouriteimage.image = UIImage(named: myArray[indexPath.row].favImage)
        cell.favouritename.text = myArray[indexPath.row].favName
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
              
             self.myArray.remove(at: indexPath.row)
              //reload the table to avoid index out of bounds crash..
             self.mytableview.deleteRows(at: [indexPath], with: .automatic)
             
              complete(true)
          }
          
          
          let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
          configuration.performsFirstActionWithFullSwipe = true
             //self.cartTableView.reloadData()
          return configuration
      }
    
    
    
    
    
    
    
    @IBOutlet weak var mytableview: UITableView!
    var myArray = [favData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        mytableview.dataSource = self
        mytableview.delegate = self
          
                                    guard let userId = Auth.auth().currentUser?.uid else {return}
                   //print(userId)
                   let db = Firestore.firestore()
                   

              db.collection("favourites").whereField("uid", isEqualTo: userId)
                  .getDocuments() {[weak self] (querySnapshot, err) in
                      if let err = err {
                          print("Error getting documents: \(err)")
                      } else {
                          for document in querySnapshot!.documents {
                           let name = document.data()["name"] as? String
                           let image = document.data()["image"] as? String
                             
                              //print(document.data())
                             
                              let doc = favData(FName: name ?? "" , FImg: image ?? "")
                             
                              self?.myArray.append(doc)
                              //let Myindex = IndexPath(row: (self?.arr.count)!-1, section: 0)
                              //self?.cartTableView.beginUpdates()
                              //self?.cartTableView.insertRows(at: [Myindex], with: .top)
                              //self?.cartTableView.endUpdates()
                              self?.mytableview.reloadData()

                          
                          }
                      }
                     // self?.cartTableView.reloadData()
                      
                      
              }
              
        
        
    
    }
    

 

}
