//
//  ContactPickerHandler.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 18/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import CoreData
import Contacts

protocol ContactPickerHandler {

    func handleContact(contact: CNContact, withPhoneNumber phoneNumber: String)
}
