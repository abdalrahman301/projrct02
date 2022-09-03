//
//  orderData.swift
//  projrct
//
//  Created by htu on 9/3/22.
//  Copyright © 2022 htu. All rights reserved.
//

import Foundation
class orderData {
    var orderstatus : String
    var orderprice : Double
    var orderdate : String
    var orderadress : String
    init(oStatus : String , oPrice : Double , oDate : String , oAdress : String) {
        orderstatus = oStatus
        orderprice = oPrice
        orderdate = oDate
        orderadress = oAdress
    }
}
