//
//  CreateRecordViewController.swift
//  TestAPartnerBNet
//
//  Created by Елизавета Щербакова on 10.08.2020.
//  Copyright © 2020 Sсherbakova Elizaveta Nikolaevna. All rights reserved.
//

import UIKit

class CreateEntryViewController: UIViewController {
    
    var apIManager: APIManager!
    
    var delegate: AllEntriesViewControllerDelegate!
    
    @IBOutlet weak var textView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = "Начните ввод текста..."
        textView.textColor = .lightGray
        textView.delegate = self
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        guard let text = textView.text else { return }
        apIManager.addEntry(body: text){ [weak self] error in
            if error == nil {
                self?.delegate.getEntries()
                self?.dismiss(animated: true, completion: nil)
            }
            else {
                self?.showAlert(title: "Отсутствует соединение с сервером", message: "Пожалуста, проверьте соединение с сетью и повторите попытку.", titleAction: "Ок")
            }
        }
    }

}

extension CreateEntryViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "Начните ввод текста..." && textView.textColor == .lightGray)
        {
            textView.text = ""
            textView.textColor = .label
        }
        textView.becomeFirstResponder() //Optional
    }

    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = "Начните ввод текста..."
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}
