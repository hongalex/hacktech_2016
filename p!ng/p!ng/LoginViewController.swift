//
//  ViewController.swift
//  p!ng
//
//  Created by Kyle Tan on 2/27/16.
//  Copyright © 2016 yakk. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: pingTextField!
    @IBOutlet weak var passwordTextField: pingTextField!
    @IBOutlet weak var buttonView: UIView!
    
    override func viewDidAppear(animated: Bool) {
        if (PFUser.currentUser() != nil) {
            DataManager.sharedInstance.getHome({home in
                if (home != nil) {
                    self.performSegueWithIdentifier("dashboardSegue", sender: self)
                } else {
                    self.performSegueWithIdentifier("LoginSegue", sender: self)
                }
            })
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //button view
        buttonView.layer.cornerRadius = 10;
        buttonView.layer.masksToBounds = true;
        
        /*if (self.navigationItem.leftBarButtonItem != nil) {
            self.navigationItem.leftBarButtonItem!.enabled = false
        }*/
        self.navigationController?.setNavigationBarHidden(self.navigationController?.navigationBarHidden == false, animated: true)
        self.navigationItem.setHidesBackButton(true, animated:false)
        if (self.tabBarController != nil) {
            self.tabBarController!.tabBar.hidden = true
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

    }

    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func LoginClicked(sender: AnyObject) {
        DataManager.sharedInstance.loginUser(emailTextField.text!,password: passwordTextField.text!, completion: {successful in
            if(successful) {
                DataManager.sharedInstance.getHome({home in
                    if (home != nil) {
                        self.performSegueWithIdentifier("dashboardSegue", sender: self)
                    } else {
                        self.performSegueWithIdentifier("LoginSegue", sender: self)
                    }
                })
            } else {
                self.passwordTextField.text="";
            }
        })
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
