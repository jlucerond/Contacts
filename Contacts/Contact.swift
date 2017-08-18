//
//  Contact.swift
//  Contacts
//
//  Created by Joe Lucero on 8/18/17.
//  Copyright © 2017 Joe Lucero. All rights reserved.
//

import Foundation
import CloudKit

class Contact {
    let name: String
    var phoneNumber: String?
    var email: String?
    var recordID: CKRecordID?
    
    init(name: String, phoneNumber: String?, email: String?) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
    init?(record: CKRecord) {
        guard record.recordType == Constants.contactRecordType,
            let name = record[Constants.contactName] as? String else { return nil }
        
        self.recordID = record.recordID
        self.name = name
        
        if let phoneNumber = record[Constants.contactPhoneNumber] as? String {
            self.phoneNumber = phoneNumber
        }
        
        if let email = record[Constants.contactEmail] as? String {
            self.email = email
        }
    }
    
    // FIXME: - Will this work with optional values here??
    var asCKRecord: CKRecord {
        let record = CKRecord(recordType: Constants.contactRecordType)
        self.recordID = record.recordID
        
        record[Constants.contactName] = name as CKRecordValue
        record[Constants.contactPhoneNumber] = phoneNumber as CKRecordValue?
        record[Constants.contactEmail] = email as CKRecordValue?
        
        return record
    }
}
