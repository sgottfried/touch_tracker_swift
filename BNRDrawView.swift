//
//  BNRDrawView.swift
//  TouchTrackerSwift
//
//  Created by Sam Gottfried on 9/6/14.
//  Copyright (c) 2014 Sam Gottfried. All rights reserved.
//

import UIKit

class BNRDrawView: UIView {

    var linesInProgress = [NSValue : BNRLine]()
    var finishedLines : [BNRLine] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.grayColor()
        multipleTouchEnabled = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func strokeLine(line: BNRLine)
    {
        let bp = UIBezierPath()
        bp.lineWidth = 10
        bp.lineCapStyle = kCGLineCapRound
        
        bp.moveToPoint(line.begin!)
        bp.addLineToPoint(line.end!)
        bp.stroke()
    }
    
    override func drawRect(rect: CGRect)
    {
        for line in finishedLines {
            strokeLine(line)
        }
        
        UIColor.redColor().set()
        for (key, line) in linesInProgress {
            strokeLine(line)
        }
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for t in touches {
            let location = t.locationInView(self)
            let line = BNRLine()
            line.begin = location
            line.end = location
            let key = NSValue(nonretainedObject: t)
            linesInProgress[key] = line
            
        }
       
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for t in touches {
            let key = NSValue(nonretainedObject: t)
            let line : BNRLine? = linesInProgress[key]
            line!.end = t.locationInView(self)
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for t in touches {
            let key = NSValue(nonretainedObject: t)
            let line = linesInProgress[key]
            finishedLines.append(line!)
            linesInProgress.removeValueForKey(key)
        }
        
        setNeedsDisplay()
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        for t in touches {
            let key = NSValue(nonretainedObject: t)
            linesInProgress.removeValueForKey(key)
            setNeedsDisplay()
        }
    }
}
