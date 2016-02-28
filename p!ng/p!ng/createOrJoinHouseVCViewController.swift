//
//  createOrJoinHouseVCViewController.swift
//  p!ng
//
//  Created by Kyle Tan on 2/27/16.
//  Copyright © 2016 yakk. All rights reserved.
//

import UIKit



class createOrJoinHouseVCViewController: UIViewController {

    @IBOutlet weak var createButtonView: UIView!
    @IBOutlet weak var joinButtonView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated:false)
        
        createButtonView.layer.cornerRadius = 10;
        createButtonView.layer.masksToBounds = true;
        
        joinButtonView.layer.cornerRadius = 10;
        joinButtonView.layer.masksToBounds = true;
        
        self.navigationController?.setNavigationBarHidden(self.navigationController?.navigationBarHidden == false, animated: true)
        self.navigationItem.setHidesBackButton(true, animated:false)
        if (self.tabBarController != nil) {
            self.tabBarController!.tabBar.hidden = true
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
