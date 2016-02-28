//
//  CreateAccountViewController.swift
//  p!ng
//
//  Created by Kyle Tan on 2/27/16.
//  Copyright © 2016 yakk. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var firstNameTF: pingTextField!
    
    @IBOutlet weak var lastNameTF: pingTextField!
   
    @IBOutlet weak var emailTF: pingTextField!
    
    @IBOutlet weak var passwordTF: pingTextField!
    @IBOutlet weak var verifyPWTF: pingTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        //button view
        buttonView.layer.cornerRadius = 10;
        buttonView.layer.masksToBounds = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Register(sender: AnyObject) {
        if(passwordTF.text==verifyPWTF.text) {
            DataManager.sharedInstance.registerUser(emailTF.text!, password: passwordTF.text!, firstName: firstNameTF.text!, lastName: lastNameTF.text!, completion:{ success in
                if(success) {
                    self.performSegueWithIdentifier("RegisterSegue", sender: sender)
                } else {
                    self.emailTF.text="";
                    self.passwordTF.text="";
                    self.verifyPWTF.text="";
                }
                
            })
        } else {
            self.passwordTF.text="";
            self.verifyPWTF.text="";
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
