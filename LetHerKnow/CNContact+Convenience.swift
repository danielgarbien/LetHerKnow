//
//  CNContact+Convenience.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 14/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import Contacts

extension CNContact {
    
    func displayName() -> String {
        if nickname.isEmpty == false {
            return nickname
        }
        let nameComponents = [namePrefix, givenName, middleName, familyName, nameSuffix].filter(){ $0.isEmpty == false }
        return " ".join(nameComponents)
    }
    
    func firstPhoneNumber() -> String? {
        if let phoneNumber = phoneNumbers.first?.value as? CNPhoneNumber {
            return phoneNumber.stringValue
        }
        return nil
    }
}
