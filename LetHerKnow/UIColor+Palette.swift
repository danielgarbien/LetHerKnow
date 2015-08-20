//
//  UIColor+Palette.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 20/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    enum KnotColor: String {
        case Navy = "#2C3E50"
        case Pink = "#FC4349"
        case Gray = "#D7DADB"
        case Blue = "#6CBCDB"
        case White = "#FFFFFF"
    }
    
    convenience init(knotColor: KnotColor) {
        self.init(rgba: knotColor.rawValue)
    }
}

