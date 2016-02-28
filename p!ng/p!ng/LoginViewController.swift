//
//  ViewController.swift
//  p!ng
//
//  Created by Kyle Tan on 2/27/16.
//  Copyright © 2016 yakk. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: pingTextField!
    @IBOutlet weak var passwordTextField: pingTextField!
    @IBOutlet weak var buttonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //button view
        buttonView.layer.cornerRadius = 10;
        buttonView.layer.masksToBounds = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func Login(sender: AnyObject) {
        DataManager.sharedInstance.loginUser(emailTextField.text!,password: passwordTextField.text!, completion: {successful in
            if(successful) {
                self.performSegueWithIdentifier("LoginSegue", sender: sender)
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
