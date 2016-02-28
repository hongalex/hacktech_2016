//
//  SendViewController.swift
//  p!ng
//
//  Created by Yuna Lee on 2/27/16.
//  Copyright © 2016 yakk. All rights reserved.
//

import UIKit

class SendViewController: UIViewController {

    
    var buttonIndex:Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func trashButton(sender: AnyObject) {
        buttonIndex = 0;
        self.performSegueWithIdentifier("pingDetail", sender: self)
    }

    @IBAction func broomButton(sender: AnyObject) {
        buttonIndex = 1;
        self.performSegueWithIdentifier("pingDetail", sender: self)
    }
    
    @IBAction func dishButton(sender: AnyObject) {
        buttonIndex = 2;
        self.performSegueWithIdentifier("pingDetail", sender: self)
    }
    
    @IBAction func fridgeButton(sender: AnyObject) {
        buttonIndex = 3;
        self.performSegueWithIdentifier("pingDetail", sender: self)
    }
    
    @IBAction func volumeButton(sender: AnyObject) {
        buttonIndex = 4;
        self.performSegueWithIdentifier("pingDetail", sender: self)
    }
    @IBAction func toiletButton(sender: AnyObject) {
        buttonIndex = 5;
        self.performSegueWithIdentifier("pingDetail", sender: self)
    }
    @IBAction func billButton(sender: AnyObject) {
        buttonIndex = 6;
        self.performSegueWithIdentifier("pingDetail", sender: self)
    }
    @IBAction func keyButton(sender: AnyObject) {
        buttonIndex = 7;
        self.performSegueWithIdentifier("pingDetail", sender: self)
    }
    @IBAction func toiletPaperButton(sender: AnyObject) {
        buttonIndex = 8;
        self.performSegueWithIdentifier("pingDetail", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "pingDetail")
        {
            let detailVC:detailViewController = segue.destinationViewController as! detailViewController
            NSLog("sending @i",self.buttonIndex)
            detailVC.buttonNumber = self.buttonIndex;
        }
    }

}
