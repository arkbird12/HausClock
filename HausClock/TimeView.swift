//
//  TimeView.swift
//  HausClock
//
//  Created by Tom Brown on 10/21/14.
//  Copyright (c) 2014 not. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class TimeView: UIView {
    @IBOutlet var button: UIButton!
    @IBOutlet var label: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Colors
    let blackColor = UIColor.blackColor()
    let whiteColor = UIColor.whiteColor()
    let blueColor = "#91c4c5".UIColor
    let redColor = "#ff0000".UIColor
    
    func updateWithViewModel(player: Player){
        
        // Set colors
        switch player.state {
        case .Active:
            button.backgroundColor = blueColor
            label.textColor = blackColor
        case .Waiting:
            button.backgroundColor = blackColor
            label.textColor = whiteColor
        }
        
        // Set seconds remaining
        label.text = player.secondsRemainingAsString()
    }
}