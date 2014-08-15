//
//  AudioLibrary.swift
//  Tuneful
//
//  Created by Kevin Scott on 8/15/14.
//  Copyright (c) 2014 Kevin Scott. All rights reserved.
//

import Foundation
import UIKit

class AudioLibrary : UIViewController, UITableViewDataSource {
    var items : [Audio] = []
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        //        println("count: \(self.items.count)")
        //        return 1
        return self.items.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.text = String(format: "%i", indexPath.row+1)
        cell.backgroundColor = UIColor.yellowColor()
        
        let index = indexPath.row
        //        cell.contentView.autoresizingMask = .FlexibleWidth
        cell.contentView.addSubview(self.items[index].view)
        self.items[index].view.frame = cell.contentView.frame
        self.items[index].audioPlot.frame = cell.contentView.frame
        
        println(tableView.frame)
        //        cell.contentView = UIView()
        //        cell.backgroundView = self.items[index].view
        //        cell.textLabel.text = "something"
        //        cell.addSubview(self.items[index].view)
        return cell
    }

    func add(url: NSURL) {
        let item = Audio(url: url)
        
        self.items.append(item)

    }
    
    

}