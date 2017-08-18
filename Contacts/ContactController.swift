//
//  ContactController.swift
//  Contacts
//
//  Created by Joe Lucero on 8/18/17.
//  Copyright © 2017 Joe Lucero. All rights reserved.
//

import Foundation
import CloudKit

class ContactController {
    static let shared = ContactController()
    var contacts: [Contact] = [] {
        didSet {
            contacts.sort { (lhs, rhs) -> Bool in
                return lhs.name < rhs.name
            }
            NotificationCenter.default.post(name: Constants.contactsChangedNotification, object: nil)
        }
    }
    fileprivate let ckManager = CloudKitManager()
    private init() {
        loadContacts()
    }
}

extension ContactController {
    func saveNewContact(name: String,
                     phoneNumber: String?,
                     email: String?,
                     completion: @escaping (Bool) -> Void) {
        let contact = Contact(name: name, phoneNumber: phoneNumber, email: email)
        
        ckManager.save(record: contact.asNewCKRecord) { (_, error) in
            if let error = error {
                print("Error \(#file) \(#function): \(error.localizedDescription)")
                completion(false)
                return
            }
            
            self.contacts.append(contact)
            completion(true)
        }
    }
    
    fileprivate func loadContacts() {
        ckManager.performQueryWith(recordType: Constants.contactRecordType,
                                   sortedBy: Constants.contactName) { (records, error) in
                                    if let error = error {
                                        print("Error \(#file) \(#function): \(error.localizedDescription)")
                                        return
                                    }
                                    
                                    guard let records = records else { return }
                                    
                                    self.contacts = records.flatMap{ Contact(record: $0) }
        }
    }
    
    func updateContact(contact: Contact,
                       withNewName name: String,
                       withNewPhoneNumber phoneNumber: String?,
                       withNewEmail email: String?,
                       completion: @escaping (Bool) -> Void) {
        
        guard contact.recordID != nil else { return }
        
        contact.update(name: name, phoneNumber: phoneNumber, email: email)
        
        guard let contactAsCKRecord = contact.asExistingCKRecord else { return }
        
        ckManager.update(record: contactAsCKRecord) { (success) in
            completion(success)
        }
    }
}
