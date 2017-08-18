//
//  ContactsDetailTableViewController.swift
//  Contacts
//
//  Created by Joe Lucero on 8/18/17.
//  Copyright © 2017 Joe Lucero. All rights reserved.
//

import UIKit

class ContactsDetailTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        
        guard let name = nameTextField.text,
            !name.isEmpty else { return }
        
        let phoneNumber = phoneNumberTextField.text
        let email = emailTextField.text
        
        ContactController.shared.saveContact(name: name,
                                             phoneNumber: phoneNumber,
                                             email: email){ success in
                                                if success {
                                                    self.dismiss(animated: true, completion: nil)
                                                } else {
                                                    self.displayAlert(title: "Alert", message: "Trouble Saving to iCloud")
                                                }
        }
    }
    
    func displayAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}
