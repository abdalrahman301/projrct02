//
//  CartViewController.swift
//  projrct
//
//  Created by htu on 8/23/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit

class CartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = cartTableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        cell.imageproduct.image = arr[indexPath.row].CartImage
        cell.nameproduct.text = arr[indexPath.row].CartName
        cell.numberproduct.text = ("\(arr[indexPath.row].CartNumber)X")
        cell.priceproduct.text = arr[indexPath.row].CartPrice
        //tableView.reloadData()
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
         return configuration
     }
    
    
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var checkOut: UIButton!
    var imagecartrecieved = UIImage()
    var pricecartrecieved = ""
    var numbercartrecieved = ""
    var namecartrecieved = ""
    
    var arr = [CartData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleFilledButton(checkOut)
       // cartTableView.rowHeight = UITableView.automaticDimension;
       // cartTableView.estimatedRowHeight = 60.0;
      
        cartTableView.dataSource = self
        cartTableView.delegate = self
        //cartTableView.reloadData()
        
        
        
          let arr0 = CartData(CName: namecartrecieved, CImg: imagecartrecieved, CPrc: pricecartrecieved, CNmbr: numbercartrecieved)
        arr.append(arr0)
        let Myindex = IndexPath(row: arr.count-1, section: 0)
        cartTableView.beginUpdates()
        cartTableView.insertRows(at: [Myindex], with: .top)
        cartTableView.endUpdates()

    }

    
    

}
