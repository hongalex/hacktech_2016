//
//  JoinHomeViewController.swift
//  p!ng
//
//  Created by Kyle Tan on 2/27/16.
//  Copyright © 2016 yakk. All rights reserved.
//

import UIKit
import Parse

class JoinHomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var redView: UIView!
    
    var homes : [PFObject] = [];
    //var houseNames : [String] = [];// = ["Test1","Test2","Test3"]//put shit here for display in the table
    var selectedName : String = ""
    var selectedIndex : Int = -1
    
    @IBAction func joinHome(sender: AnyObject) {
        if (selectedIndex >= 0) {
            DataManager.sharedInstance.joinHome(homes[selectedIndex], completion: {successful in
                if (successful) {
                    self.performSegueWithIdentifier("joinHomeSegue", sender: self)
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        redView.layer.cornerRadius = 10;
        redView.layer.masksToBounds = true;
        
        homeTableView.backgroundColor = UIColor.clearColor()
        
        DataManager.sharedInstance.getInvitedHomes({homes in
            self.homes = homes!;
            self.homeTableView.reloadData();
        })
        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated:false)
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return homes.count
    }
    
    func numberOfSectionsInTableView(tableView:UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        
        
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("homeCell", forIndexPath: indexPath) as UITableViewCell
        
        let name = self.homes[indexPath.row]["name"] as! String?
        cell.textLabel!.text = name
        cell.backgroundColor = UIColor.clearColor();
       
        cell.textLabel?.textAlignment = NSTextAlignment.Right;
        cell.textLabel?.textAlignment = NSTextAlignment.Left;
        cell.textLabel?.font = cell.textLabel?.font.fontWithSize(16);
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("homeCell", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        selectedIndex = indexPath.row
        selectedName = (self.homes[indexPath.row]["name"] as! String?)!
        
        /*cell.textLabel?.text = newBookCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        self.homeTableView.reloadData();
        
        cell.backgroundColor = UIColor.clearColor();
        let tempImage = UIImage(named: "home")
        cell.imageView?.image = tempImage*/
        
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
