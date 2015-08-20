//
//  SubtitleCell.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 20/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import UIKit

class SubtitleCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
        self.textLabel?.textColor = UIColor(knotColor: .Navy)
        self.detailTextLabel?.textColor = UIColor(knotColor: .Navy)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
