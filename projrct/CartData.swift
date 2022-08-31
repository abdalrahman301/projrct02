//
//  CartData.swift
//  projrct
//
//  Created by htu on 8/23/22.
//  Copyright © 2022 htu. All rights reserved.
//

import Foundation
import UIKit
class CartData {
    var CartName : String
    let CartImage : String
    var CartPrice : Double
    var CartNumber : Double
    
    
    init(CName : String , CImg : String , CPrc : Double, CNmbr : Double) {
        CartName = CName
        CartImage = CImg
        CartPrice = CPrc
        CartNumber = CNmbr
        
        
    }
}
