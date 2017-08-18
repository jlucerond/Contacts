//
//  Constants.swift
//  Contacts
//
//  Created by Joe Lucero on 8/18/17.
//  Copyright © 2017 Joe Lucero. All rights reserved.
//

import Foundation

enum Constants {
    // Record Type
    static let contactRecordType = "Contact"
    
    // Properties
    static let contactName = "Name"
    static let contactPhoneNumber = "PhoneNumber"
    static let contactEmail = "Email"
    
    // Notification
    static let contactsChangedNotification = Notification.Name("ContactsHaveChanged")
}
