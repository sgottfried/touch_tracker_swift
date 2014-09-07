//
//  BNRDrawViewController.swift
//  TouchTrackerSwift
//
//  Created by Sam Gottfried on 9/6/14.
//  Copyright (c) 2014 Sam Gottfried. All rights reserved.
//

import UIKit

class BNRDrawViewController: UIViewController {
    override func loadView() {
        self.view = BNRDrawView(frame: CGRectZero)
    }
}
