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
    let CartImage : UIImage
    var CartPrice : String
    var CartNumber : String
    
    
    init(CName : String , CImg : UIImage , CPrc : String, CNmbr : String ) {
        CartName = CName
        CartImage = CImg
        CartPrice = CPrc
        CartNumber = CNmbr
        
        
    }
}
