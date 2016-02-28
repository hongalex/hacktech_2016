//
//  JoinHomeViewController.swift
//  p!ng
//
//  Created by Kyle Tan on 2/27/16.
//  Copyright © 2016 yakk. All rights reserved.
//

import UIKit

class JoinHomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var redView: UIView!
    
    var houseNames : [String] = ["Test1","Test2","Test3"]//put shit here for display in the table
    
    override func viewDidLoad() {
        super.viewDidLoad()

        redView.layer.cornerRadius = 10;
        redView.layer.masksToBounds = true;
        
        homeTableView.backgroundColor = UIColor.clearColor()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return houseNames.count
    }
    
    func numberOfSectionsInTableView(tableView:UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        
        
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("homeCell", forIndexPath: indexPath) as UITableViewCell
        
        let name = self.houseNames[indexPath.row]
        cell.textLabel!.text = name
        cell.backgroundColor = UIColor.clearColor();
       
        cell.textLabel?.textAlignment = NSTextAlignment.Right;
        cell.textLabel?.textAlignment = NSTextAlignment.Left;
        cell.textLabel?.font = cell.textLabel?.font.fontWithSize(10);
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("homeCell", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        let newBookCell = self.houseNames[indexPath.row]
        cell.textLabel?.text = newBookCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        self.homeTableView.reloadData();
        
        cell.backgroundColor = UIColor.clearColor();
        let tempImage = UIImage(named: "home")
        cell.imageView?.image = tempImage
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
