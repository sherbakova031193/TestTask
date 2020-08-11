//
//  RecordViewController.swift
//  TestAPartnerBNet
//
//  Created by Елизавета Щербакова on 10.08.2020.
//  Copyright © 2020 Sсherbakova Elizaveta Nikolaevna. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
    
    @IBOutlet weak var modificationLabel: UILabel!
    @IBOutlet weak var modificationDateLabel: UILabel!
    @IBOutlet weak var textEntryLabel: UILabel!

    
    var entry: Entry!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updatUI()
    }

    private func updatUI()  {

        guard let entry = entry else { return }
        
        textEntryLabel.text = entry.text

        navigationItem.title = "Запись от \(entry.creationDate)"
        if entry.isChange {
            modificationDateLabel.text = entry.modificationDate
        }
        else {
            modificationDateLabel.isHidden = true
            modificationLabel.isHidden = true
        }
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
