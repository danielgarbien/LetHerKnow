//
//  ConfigurationViewController.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 11/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation

protocol ConfigurationViewControllerDelegate {
    func configurationViewControllerDelegateDidFinish(viewController: ConfigurationViewController)
}

class ConfigurationViewController: ViewController {
    
    var delegate: ConfigurationViewControllerDelegate?
    
    @IBAction func doneTapped() {
        delegate?.configurationViewControllerDelegateDidFinish(self)
    }
}
