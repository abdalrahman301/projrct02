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
      
           return cell
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
        
      
        cartTableView.dataSource = self
        cartTableView.delegate = self
        cartTableView.reloadData()

    }

    
    

}
