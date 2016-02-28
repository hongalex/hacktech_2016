//
//  createAHomeViewController.swift
//  p!ng
//
//  Created by Kyle Tan on 2/27/16.
//  Copyright © 2016 yakk. All rights reserved.
//

import UIKit

class createAHomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var redView: UIView!
    
    @IBOutlet weak var emailTextField: pingTextField!
    var namesToDisplay = [String]();
    
    @IBOutlet weak var homeName: pingTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated:false)

        self.tableView.backgroundColor = UIColor.clearColor()
        
        redView.layer.cornerRadius = 10;
        redView.layer.masksToBounds = true;
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

        
    }

    @IBAction func addEmail(sender: AnyObject) {
        if(emailTextField.text != "")
        {
            namesToDisplay.append(emailTextField.text!)
           self.tableView.reloadData();
            emailTextField.text = "";
            
        }
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
        
        return namesToDisplay.count
    }
    
    func numberOfSectionsInTableView(tableView:UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        
        
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("emailCell", forIndexPath: indexPath) as UITableViewCell
        
        let email = self.namesToDisplay[indexPath.row]
        cell.textLabel!.text = email
        cell.backgroundColor = UIColor.clearColor();
        
        return cell
    }

    @IBAction func CreateHomeClicked(sender: AnyObject) {
        DataManager.sharedInstance.createHome(homeName.text!, completion: { success in
            if(success) {
                //navigate to next view with segue
                self.performSegueWithIdentifier("createHomeSegue", sender: self)
            } else {
                //Perform actions on fail
            }
        })
        
        for email in namesToDisplay {
            DataManager.sharedInstance.inviteEmailToHome(email, completion: { success in
                if(success) {
                    //Perform actions on success
                } else {
                    //Perform actions on fail
                }
            })
        }
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
