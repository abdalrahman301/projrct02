//
//  AccountViewController.swift
//  projrct
//
//  Created by htu on 8/10/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit

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
    

    @IBOutlet weak var Accountname: UILabel!
    
    @IBOutlet weak var MyTableView: UITableView!
    
    var AccountList = [AccountData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
filldata()
        MyTableView.delegate = self
        MyTableView.dataSource = self
       
    }
    
    func filldata () {
       let account1 = AccountData(AName: "Profile", AImg: "profile")
        AccountList.append(account1)
         let account2 = AccountData(AName: "My Orders", AImg: "orders")
        AccountList.append(account2)
         let account3 = AccountData(AName: "Help", AImg: "help")
               AccountList.append(account3)
         let account4 = AccountData(AName: "Log out", AImg: "logout")
               AccountList.append(account4)
    }
    
}
