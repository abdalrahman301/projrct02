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
    var perfumeDesc : String
    init(pName : String , pImg : String , pPrice : Double , pGender : String , pDesc : String) {
        perfumeName = pName
        PerfumeImage = pImg
        PerfumePrice = pPrice
        perfumeGender = pGender
        perfumeDesc = pDesc
    }
}
