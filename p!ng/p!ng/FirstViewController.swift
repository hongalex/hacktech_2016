//
//  FirstViewController.swift
//  p!ng
//
//  Created by Alex Hong on 2/27/16.
//  Copyright © 2016 yakk. All rights reserved.
//

import UIKit
import Parse

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        /*DataManager.sharedInstance.createHome({successful in
            print("Create home ")
            print(successful)
        })*/
        
        /*DataManager.sharedInstance.inviteEmailToHome("email@example.com", completion: {successful in
            print("Invite email to home ")
            print (successful)
        })*/
        
        
        /*DataManager.sharedInstance.getInvitedHomes({homes in
            DataManager.sharedInstance.joinHome(homes![0], completion: {successful in
                print("Joined home ")
                print (successful)
            })
        })*/
        
        /*DataManager.sharedInstance.leaveHome({successful in
            print("Left home ")
            print(successful)
        })*/
        
        
        //PFUser.logOutInBackground();
        
        /*DataManager.sharedInstance.registerUser("kwu135@usc.edu", password: "asdf", firstName:"Kevin", lastName:"Wu", completion: {successful in
            print(successful)
            print(PFUser.currentUser())

        
        })*/
        
        /*DataManager.sharedInstance.loginUser("myRoommate2", password: "asdf", completion: {successful in
            print(successful)
            print(PFUser.currentUser())
        })*/
    
        
        /*DataManager.sharedInstance.getRoommates({roommates in
            print(roommates)
        })*/
        
        //    func createMessage(messageType : PFObject, toUser : PFObject, completion : (successful : Bool) -> Void) {

        
        /*DataManager.sharedInstance.getMessageTypes({messageTypes in
            DataManager.sharedInstance.getRoommates({roommates in
                DataManager.sharedInstance.createMessage(messageTypes![7], toUser: roommates![0], completion: {successful in
                    print(successful)
                })
            })
        })*/
        
        /*DataManager.sharedInstance.loginUser("myUsername", password: "myPassword", completion: {successful in
            print(successful)
            
        })*/
        
        
        
        DataManager.sharedInstance.getMessages({messages in
            DataManager.sharedInstance.seeMessage(messages![0], completion: {successful in
                print(successful)
                DataManager.sharedInstance.getMessages({messages1 in
                  print(messages1)
                })

            })

        })
        
        
        
        
        

        
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

