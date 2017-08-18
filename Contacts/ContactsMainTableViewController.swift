//
//  ContactsMainTableViewController.swift
//  Contacts
//
//  Created by Joe Lucero on 8/18/17.
//  Copyright © 2017 Joe Lucero. All rights reserved.
//

import UIKit

class ContactsMainTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadTable),
                                               name: Constants.contactsChangedNotification,
                                               object: nil)
    }

    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// Table View Data Source
extension ContactsMainTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactController.shared.contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = ContactController.shared.contacts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        cell.textLabel?.text = contact.name
        return cell
    }
}

// Navigation
extension ContactsMainTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditContact" {
            guard let nextVC = segue.destination as? UINavigationController,
                let detailVC = nextVC.topViewController as? ContactsDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let selectedContact = ContactController.shared.contacts[indexPath.row]
            detailVC.contact = selectedContact
        }
    }
}






