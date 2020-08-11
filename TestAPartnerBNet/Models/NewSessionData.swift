//
//  NewSessionData.swift
//  TestAPartnerBNet
//
//  Created by Елизавета Щербакова on 10.08.2020.
//  Copyright © 2020 Sсherbakova Elizaveta Nikolaevna. All rights reserved.
//

import Foundation


struct NewSession: Decodable {
    let status: Int
    let data: DataClass
}

struct DataClass: Decodable {
    let session: String
}
