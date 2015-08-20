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
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SoulmateCell: SubtitleCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.textLabel?.textColor = UIColor(knotColor: .White)
        self.detailTextLabel?.textColor = UIColor(knotColor: .White)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BuddyCell: SubtitleCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.textLabel?.textColor = UIColor(knotColor: .White)
        self.detailTextLabel?.textColor = UIColor(knotColor: .White)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
