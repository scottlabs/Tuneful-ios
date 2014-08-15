//
//  AudioTable.swift
//  Tuneful
//
//  Created by Kevin Scott on 7/29/14.
//  Copyright (c) 2014 Kevin Scott. All rights reserved.
//

import Foundation
import UIKit

class AudioTable : UIViewController, UITableViewDelegate {
    
    
    var tableView: UITableView = UITableView()
    let cellHeight : CGFloat = 84
    let audioLibrary = AudioLibrary()

//    var tableView = UITableView()
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init() {

        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = UIColor.greenColor()
        self.tableView.backgroundColor = UIColor.brownColor()
        self.tableView.delegate = self
        self.tableView.dataSource = audioLibrary
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        self.items.append("yo")
//        //        var row = self.items.count-1
//        var indexPath = NSIndexPath(forRow:self.items.count-1,inSection:0)
//        println(indexPath)
//        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
//        println("ok")

    }
    

    
        
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return cellHeight;
    }
    
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        var err : NSError? = nil
    }

    func add(url : NSURL) {
        self.audioLibrary.add(url);

        
        var row = audioLibrary.items.count-1
        var indexPath = NSIndexPath(forRow:row,inSection:0)

        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
    }
    
}
