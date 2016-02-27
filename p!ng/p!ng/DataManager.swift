//
//  DataManager.swift
//  p!ng
//
//  Created by Alex Hong & Kevin Wu on 2/27/16.
//  Copyright © 2016 yakk. All rights reserved.
//

import Foundation
import Parse
import Bolts


class DataManager {
    static let sharedInstance = DataManager();
    
    private init() {};
    
    
    func createHome(completion:(created: Bool)-> Void) {
        var home = PFObject(className:"Home")
        
        let relation = home.relationForKey("users")
        
        relation.addObject(PFUser.currentUser()!)
        home.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if(success) {
                completion(created : true)
            } else {
                completion(created : false)
            }
        }
    }
    
    

    
    
    /*void Login(String email, String password)
    void Register(String email, String password, String firstName, String lastName)
    void createHome()
    void inviteEmailToHome(String email)
    List<Home> getInvitedHomes()
    void joinHome(Home home)
    void leaveHome()
    List<User> getRoommates()
    void createMessage(MessageType messageType, User toUser)
    List<MessageType> getMessageType()
    List<Message> getMessages() //Pings
    */
}