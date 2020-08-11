//
//  EntryModel.swift
//  TestAPartnerBNet
//
//  Created by Елизавета Щербакова on 11.08.2020.
//  Copyright © 2020 Sсherbakova Elizaveta Nikolaevna. All rights reserved.
//

import Foundation

struct Entry {
     
    var text: String
    var shortText: String
    var creationDate: String
    var modificationDate: String
    var isChange: Bool
}


class EntryFormatter {

    public func formattingEntries(entriesData: [EntryData?]) -> [Entry?] {
        
        var entries: [Entry?] = []
        
        for entryData in entriesData  {
           let entry = formattingEntry(entryData: entryData)
            entries.append(entry)
        }
        return entries
    }
    
    public func formattingEntry(entryData: EntryData?) -> Entry? {
        
        guard let entryData = entryData else { return nil }
        
        let text  = entryData.body
        let shortText = textCropping(text: entryData.body)
        let creationDate = dateFormatting(datadate: entryData.da)
        let modificationDate = dateFormatting(datadate: entryData.dm)
        let isChange: Bool
        if creationDate == modificationDate {
            isChange = false
        }
        else {
            isChange = true
        }
        
        let entry = Entry(text: text, shortText: shortText, creationDate: creationDate, modificationDate: modificationDate, isChange: isChange)
        
        return entry
    }
    
    
    private func dateFormatting(datadate: String) -> String {
        
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        
        guard let dateDouble = Double(datadate) else { return String() }
        let date = Date(timeIntervalSince1970: dateDouble)
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    private func textCropping(text: String) -> String {
    
        var shortText = text
        
        let coutCharacter = shortText.count
               if coutCharacter > 200 {
                   print(coutCharacter)
                   let charactersForReemove =  -(coutCharacter - 197)
                   let range = shortText.index(shortText.endIndex, offsetBy: charactersForReemove)..<shortText.endIndex
                   shortText.removeSubrange(range)
                   shortText.insert(contentsOf: "...", at: shortText.endIndex)

                   
               }

        return shortText
    }
    
    
    
    
}
