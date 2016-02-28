//
//  notificationTableViewController.swift
//  p!ng
//
//  Created by Yuna Lee on 2/28/16.
//  Copyright © 2016 yakk. All rights reserved.
//

import UIKit
import Parse

class notificationTableViewController: UITableViewController {

    var objects : [PFObject] = []
    var names : [String] = []
    var notificationName : [String] = []
    var time : [String] = []
    let pictureNames : [String] = ["Trash","Broom","Dishes","Fridge", "Volume","Toilet","Bill","Key","ToiletPaper"]
    var picIndex : [Int] = [];
    var loopCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        DataManager.sharedInstance.getMessages({messages in
            self.objects = messages!;
            for message in messages! {
                print(message)
                
                let user = message["fromUser"]
                user.fetchInBackgroundWithBlock({
                    (object: PFObject?, error: NSError?) -> Void in
                    self.names.append(user["firstName"] as! String)
                    
                    let messageType = message["messageType"]
                    messageType.fetchInBackgroundWithBlock({
                        (object: PFObject?, error: NSError?) -> Void in
                        self.notificationName.append(messageType["message"] as! String)
                        self.picIndex.append(messageType["imageIndex"] as! Int)
                        let createdOn: NSDate = message.createdAt!
                        let today: NSDate = NSDate()
                        let calendar = NSCalendar.currentCalendar()
                        
                        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute], fromDate: createdOn, toDate: today, options: [])
                        
                        //let daysDif:Int = components.day
                        
                        var timeText:String

                        if (components.minute < 1)
                        {
                            timeText = "Just now"
                        }
                        else if (components.hour < 1)
                        {
                            if (components.minute == 1)
                            {
                                timeText = "A minute ago"
                            }
                            else
                            {
                                timeText = "\(components.minute) minutes ago"
                            }
                        }
                        else if (components.day < 1)
                        {
                            if (components.hour == 1)
                            {
                                timeText = "An hour ago"
                            }
                            else
                            {
                                timeText = "\(components.hour) hours ago"
                            }
                        }
                        else if (components.day < 7)
                        {
                            if (components.day == 1)
                            {
                                timeText = "A day ago"
                            }
                            else
                            {
                                timeText = "\(components.day) days ago"
                            }
                        }
                        else if (components.month < 1)
                        {
                            if (components.day/7 == 1)
                            {
                                timeText = "A week ago"
                            }
                            else
                            {
                                timeText = "\(components.day/7) week ago"
                            }
                        }
                        else if (components.year < 1)
                        {
                            if (components.month == 1)
                            {
                                timeText = "A month ago"
                            }
                            else
                            {
                                timeText = "\(components.month) months ago"
                            }
                        }
                        else
                        {
                            if (components.year == 1)
                            {
                                timeText = "A year ago"
                            }
                            else
                            {
                                timeText = "\(components.year) years ago"
                            }
                        }
                        
                        self.time.append(timeText)
                        self.loopCounter++
                        if (self.loopCounter == messages!.count){
                            self.tableView.reloadData()
                        }
                    })
                })
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath)->CGFloat {
        self.tableView.rowHeight = 100;
        return 100;
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("notificationCell", forIndexPath: indexPath)

        // Configure the cell...
        let cellText : String = String(format:"%@", notificationName[indexPath.row]);
        cell.detailTextLabel!.textColor = UIColor.grayColor();
        cell.detailTextLabel!.text = String(format: "%@, %@", names[indexPath.row],time[indexPath.row])
    
        cell.textLabel?.text = cellText;
        cell.imageView?.image = UIImage(named: self.pictureNames[picIndex[indexPath.row]]);
        
        cell.textLabel?.font = cell.textLabel?.font.fontWithSize(18);
        cell.detailTextLabel?.font = cell.textLabel?.font.fontWithSize(12)
        cell.backgroundColor = UIColor.clearColor();
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        names.removeAtIndex(indexPath.row);
        notificationName.removeAtIndex(indexPath.row)
        time.removeAtIndex(indexPath.row)
        self.picIndex.removeAtIndex(indexPath.row)
        
        DataManager.sharedInstance.seeMessage(objects[indexPath.row],completion: {successful in
        })
        self.objects.removeAtIndex(indexPath.row)
        
    
        self.tableView.reloadData();
    
    }

}
