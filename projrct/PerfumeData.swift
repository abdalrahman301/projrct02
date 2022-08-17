//
//  PerfumeData.swift
//  projrct
//
//  Created by htu on 8/3/22.
//  Copyright © 2022 htu. All rights reserved.
//

import Foundation
class PerfumeData {
    let perfumeName : String
    var PerfumeImage : String
    var PerfumePrice : Double
    var perfumeGender : String
    init(pName : String , pImg : String , pPrice : Double , pGender : String ) {
        perfumeName = pName
        PerfumeImage = pImg
        PerfumePrice = pPrice
        perfumeGender = pGender
        
    }
}
