//
//  AllNotesViewController.swift
//  TestAPartnerBNet
//
//  Created by Елизавета Щербакова on 10.08.2020.
//  Copyright © 2020 Sсherbakova Elizaveta Nikolaevna. All rights reserved.
//

import UIKit

protocol AllEntriesViewControllerDelegate: class {
    func getEntries()
}


class AllEntriesViewController: UITableViewController, AllEntriesViewControllerDelegate{
    
    public var apIManager: APIManager!
    private var entries: [Entry?]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        entries = []
       // getEntries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getEntries()
    }
        
        
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntriyTableViewCell", for: indexPath) as! EntriyTableViewCell
        
        let entry = entries[indexPath.row]
        cell.entry = entry

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let entry = entries[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               guard let nVCForEntryVC = storyboard.instantiateViewController(identifier: "NVCForEntryVC") as? UINavigationController else { return }
               let entryVC = nVCForEntryVC.topViewController as! EntryViewController
               entryVC.entry = entry
               self.showDetailViewController(nVCForEntryVC, sender: nil)
    }
  

    public func getEntries()  {
    
    let entryFormatter = EntryFormatter()
    
    apIManager.getEntries { [weak self] (entriesData, error) in
        if error == nil {
            
            self?.entries = entryFormatter.formattingEntries(entriesData: entriesData ?? [])
            self?.tableView.reloadData()
        }
        else {
            self?.showAlertNotConnection()
        }
    
        }
    }
    
    private func showAlertNotConnection() {
        
        showAlert(title: "Отсутствует соединение с сервером", message: "Пожалуста, проверьте соединение с сетью.", titleAction: "Обновить данные") { [weak self] _ in
            self?.getEntries()
        }
    }
    
    @IBAction func addEntry(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let nVCForCreateEntryVC = storyboard.instantiateViewController(identifier: "NVCForCreateEntryVC") as? UINavigationController else { return }
        let createEntryVC = nVCForCreateEntryVC.topViewController as! CreateEntryViewController
        createEntryVC.apIManager = apIManager
        createEntryVC.delegate = self
        self.showDetailViewController(nVCForCreateEntryVC, sender: nil)
    }
}


