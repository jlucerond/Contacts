//
//  CloudKitManager.swift
//  Contacts
//
//  Created by Joe Lucero on 8/18/17.
//  Copyright © 2017 Joe Lucero. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitManager {
    private let ckPrivateDB = CKContainer.default().privateCloudDatabase
    
    // Save a Contact
    func save(record: CKRecord, completion: @escaping (CKRecord?, Error?) -> Void) {
        ckPrivateDB.save(record, completionHandler: completion)
    }
    
    // Update a Contact
    
    
    // Fetch all Contacts
    func performQueryWith(recordType: String,
                          sortedBy: String?,
                          completion: @escaping ([CKRecord]?, Error?) -> Void) {
        let predicate = NSPredicate(value: true)
        let sortDescriptor = NSSortDescriptor(key: sortedBy, ascending: true)
        let query = CKQuery(recordType: recordType, predicate: predicate)
        query.sortDescriptors = [sortDescriptor]
        
        ckPrivateDB.perform(query,
                            inZoneWith: nil,
                            completionHandler: completion)
    }
    
}
