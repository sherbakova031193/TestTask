//
//  RecordTableViewCell.swift
//  TestAPartnerBNet
//
//  Created by Елизавета Щербакова on 10.08.2020.
//  Copyright © 2020 Sсherbakova Elizaveta Nikolaevna. All rights reserved.
//

import UIKit

class EntriyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var modificationLabel: UILabel!
    @IBOutlet weak var modificationDateLabel: UILabel!
    @IBOutlet weak var textEntryLabel: UILabel!
    
    
    var dateFormatter: DateFormatter!
    
    var entry: Entry! {
        didSet {
           updatUI()
        }
    }

    private func updatUI()  {

        guard let entry = entry else { return }
        
        textEntryLabel.text = entry.shortText

        creationDateLabel.text = entry.creationDate
        if entry.isChange {
            modificationDateLabel.text = entry.modificationDate
        }
        else {
            modificationDateLabel.isHidden = true
            modificationLabel.isHidden = true
        }
    }
}
