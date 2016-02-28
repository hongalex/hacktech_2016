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

/**
 *
 * DataManager
 *
 * Singleton data manager class that the controllers call with a completion handler
 * to make calls to the database and then update the UI after the database call is
 * complete.
 *
 * !!!!!!!!!!!!!!!NOT TESTED!!!!!!!!!!!!!!! - KEVIN WU
 *
 * Functions Available (The Completion Handler will take in the return value and is the last parameter)
 * -------------------
 * void Login(String email, String password)
 * void Register(String email, String password, String firstName, String lastName)
 * void createHome()
 * void inviteEmailToHome(String email)
 * List<Home> getInvitedHomes()
 * void joinHome(Home home)
 * void leaveHome()
 * List<User> getRoommates()
 * void createMessage(MessageType messageType, User toUser)
 * List<MessageType> getMessageTypes()
 * List<Message> getMessages() //Pings
 * void seeMessage(Message message)
 */
class DataManager {
    static let sharedInstance = DataManager();
    
    private init() {};
    
    
    /**
     * @method registerUser
     *
     * Creates a User object on the parse database.
     *
     * @param email- Email of the user 
     * @param password- Password of the user
     * @param firstName- User's first name
     * @param lastName- User's last name
     *
     */
    func registerUser(email: NSString, password: NSString, firstName: NSString, lastName: NSString, completion: (successful : Bool) -> Void) {
        let user = PFUser()
        user.username = email as String
        user.email = email as String
        user.password = password as String
        user["firstName"] = firstName as String
        user["lastName"] = lastName as String
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                completion(successful : false)
                print (errorString);
            } else {
                // Hooray! Let them use the app now.
                completion(successful : true)

            }
        }
    }
    
    /**
     * @method loginUser
     *
     * Log in a user with the given credentials.
     *
     * @param email- Email of the user
     * @param password- Password of the user
     *
     */
    func loginUser(email: NSString, password: NSString, completion: (successful: Bool) -> Void) {
        PFUser.logInWithUsernameInBackground(email as String, password: password as String) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                completion(successful : true)
            } else {
                // The login failed. Check error to see why.
                completion(successful : false)

            }
        }
    }
    
    
    
    /**
     * @method createHome
     *
     * Creates a Home object on the Parse DB. Adds the current user to that home.
     *
     * @param A String that describes the address of the house
     * @param A completion handler that takes in whether the method was successfully run
     */
    func createHome(name: NSString, completion : (successful : Bool) -> Void) {
        let home = PFObject(className:"Home")
        home["name"] = name as String;
        
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
    
    /**
     * @method getHome
     *
     * Returns the current user's home 
     *
     * @param A completion handler that takes in the home PFObject and updates the view with it
     */
    func getHomeName(completion: (home : PFObject?) -> Void) {
        let homeQuery = PFQuery(className: "Home")
        homeQuery.whereKey("users", equalTo:PFUser.currentUser()!)
        homeQuery.getFirstObjectInBackgroundWithBlock {
            (object : PFObject?, error: NSError?) -> Void in
            if error == nil {
                completion(home: object!)
            } else {
                completion(home: nil)
            }
        }
    }
    
    
    /**
     * @method inviteEmailToHome
     *
     * Adds an email to the invite list of the home allowing users with that email to
     * join the home
     *
     * @param NSString of the email that wants to be invited
     * @param A completion handler that takes in whether the method was successfully run
     */
    func inviteEmailToHome(email : NSString, completion : (successful : Bool) -> Void) {
        let homeQuery = PFQuery(className: "Home")
        homeQuery.whereKey("users", equalTo:PFUser.currentUser()!)
        homeQuery.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                completion(successful : false)
            } else {
                object!.addUniqueObject(email, forKey: "invitedEmails")
                object!.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if(success) {
                        completion(successful : true)
                    } else {
                        completion(successful : false)
                    }
                }
            }
        }
    }
    
    /**
     * @method getInvitedHomes
     *
     * Gets the homes a user is invited to for the join screen
     *
     * @param A completion handler that takes in the home PFObjects and updates the view with it
     */
    func getInvitedHomes(completion : (homes : [PFObject]?) -> Void) {
        let homeQuery = PFQuery(className: "Home")
        homeQuery.whereKey("invitedEmails", equalTo:PFUser.currentUser()!["email"])
        homeQuery.findObjectsInBackgroundWithBlock {
            (objects : [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                completion(homes: objects)
            } else {
                completion(homes: nil)
            }
        }
    }

    /**
     * @method joinHome
     *
     * Adds the user to the home
     *
     * @param Home PFObject that user is joining, A completion handler that takes in whether the method was successfully run
     */
    func joinHome(home : PFObject, completion : (successful : Bool) -> Void) {
        /*let homeQuery = PFQuery(className: "Home")
        homeQuery.whereKey("objectId", equalTo: home["objectId"])
        homeQuery.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                completion(successful : false)
            } else {
                let relation = object!.relationForKey("users")
                relation.addObject(PFUser.currentUser()!)
                object!.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if(success) {
                        completion(successful : true)
                    } else {
                        completion(successful : false)
                    }
                }
            }
        }*/
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
    
    /**
     * @method leaveHome
     *
     * Removes the user from the home
     *
     * @param A completion handler that takes in whether the method was successfully run
     */
    func leaveHome(completion : (successful : Bool) -> Void) {
        let homeQuery = PFQuery(className: "Home")
        homeQuery.whereKey("users", equalTo:PFUser.currentUser()!)
        homeQuery.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                completion(successful : false)
            } else {
                let relation = object!.relationForKey("users")
                relation.removeObject(PFUser.currentUser()!)
                object!.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if(success) {
                        completion(successful : true)
                    } else {
                        completion(successful : false)
                    }
                }
            }
        }
    }
    
    /**
     * @method getRoommates
     *
     * Gets the Roommates PFObjects
     *
     * @param A completion handler that takes in the roommate PFObjects and updates the view
     */
    func getRoommates(completion : (roommates : [PFObject]?) -> Void) {
        let homeQuery = PFQuery(className: "Home")
        homeQuery.whereKey("users", equalTo:PFUser.currentUser()!)
        homeQuery.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                completion(roommates : nil)
            } else {
                let relation = object!.relationForKey("users")

                relation.query().findObjectsInBackgroundWithBlock {
                    (var objects : [PFObject]?, error: NSError?) -> Void in
                    for user in objects! {
                        if(user.objectId == PFUser.currentUser()!.objectId) {
                            objects!.removeAtIndex(objects!.indexOf(user)!)
                        }
                    }
                    if error == nil {
                        completion(roommates: objects)
                    } else {
                        completion(roommates: nil)
                    }
                }
            }
        }
    }
    
    
    /**
     * @method createMessage
     *
     * Creates a Message to be sent
     *
     * @param A message type PFObject, PFObject of the user the message is being sent to,
     *        A completion handler that takes in whether the method was successfully run
     */
    func createMessage(messageType : PFObject, toUser : PFObject, completion : (successful : Bool) -> Void) {
        let message = PFObject(className: "Message")
        message["messageType"] = messageType;
        message["toUser"] = toUser;
        message["fromUser"] = PFUser.currentUser();
        message["isSeen"] = false;
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if(success) {
                completion(successful : true)
            } else {
                completion(successful : false)
            }
        }
    }
    
    /**
     * @method getMessageTypes
     *
     * Gets all the message types that can be sent to a user
     *
     * @param A completion handler that takes in message types and updates a view
     */
    func getMessageTypes(completion : (messageTypes : [PFObject]?) -> Void) {
        let messageTypeQuery = PFQuery(className: "MessageType")
        messageTypeQuery.findObjectsInBackgroundWithBlock {
            (objects : [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                completion(messageTypes: objects)
            } else {
                completion(messageTypes: nil)
            }
        }
    }
    
    /**
     * @method getMessages
     *
     * Gets all the messages of the current user to display (Messages that haven't been seen)
     *
     * @param A completion handler that takes in the messages and then displays it on the view
     */
    func getMessages(completion : (messages : [PFObject]?) -> Void) {
        let messageQuery = PFQuery(className: "Message")
        messageQuery.whereKey("isSeen", equalTo: false)
        messageQuery.whereKey("toUser", equalTo: PFUser.currentUser()!)
        messageQuery.findObjectsInBackgroundWithBlock {
            (objects : [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                completion(messages: objects)
            } else {
                completion(messages: nil)
            }
        }
    }
    
    /**
     * @method seeMessage
     *
     * Checks off if a message is seen to no longer be displayed
     *
     * @param The message that is being seen as a PFObject, A completion handler that takes in whether the method was sucessfully run
     */
    func seeMessage(message : PFObject, completion : (successful : Bool) -> Void) {
        message["isSeen"] = true;
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if(success) {
                completion(successful : true)
            } else {
                completion(successful : false)
            }
        }
    }
}