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
    
    
    
    func createHome(completion : (successful : Bool) -> Void) {
        var home = PFObject(className:"Home")
        
        let relation = home.relationForKey("users")
        
        relation.addObject(PFUser.currentUser()!)
        home.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if(success) {
                completion(successful : true)
            } else {
                completion(successful : false)
            }
        }
    }
    
    func inviteEmailToHome(email : NSString, completion : (successful : Bool) -> Void) {
        
    }
    
    func getInvitedHomes(completion : (successful : [PFObject]) -> Void) {
        
    }

    //pass in Home's objectID for this function
    func joinHome(homeID : NSString, completion : (successful : Bool) -> Void) {
        
    }
    
    func leaveHome(completion : (successful : Bool) -> Void) {
        
    }
    
    func getRoommates(completion : (successful : [PFObject]) -> Void) {
        
    }
    
    
    //send a message using the MessageType's object ID
    func createMessage(messageID : NSString, completion : (successful : Bool) -> Void) {
        
    }
    
    //Get the available message options to display
    func getMessageType(completion : (successful : [PFObject]) -> Void) {
        
    }
    
    
    func getMessages(completion : (successful : [PFObject]) -> Void) {
        
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