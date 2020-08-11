//
//  EntriesData.swift
//  TestAPartnerBNet
//
//  Created by Елизавета Щербакова on 10.08.2020.
//  Copyright © 2020 Sсherbakova Elizaveta Nikolaevna. All rights reserved.
//

import Foundation

struct EntriesData: Decodable {
    let status: Int
    let data: [[EntryData]]
}

struct EntryData: Decodable {
    let id, body, da, dm: String
}
