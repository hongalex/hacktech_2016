//
//  detailViewController.swift
//  p!ng
//
//  Created by Yuna Lee on 2/28/16.
//  Copyright © 2016 yakk. All rights reserved.
//

import UIKit
import Parse

class detailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {

    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var pingLabel: UILabel!
    @IBOutlet weak var pingPicture: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    let key : [String] = ["Trash","Broom","Dishes","Fridge", "Volume","Toilet","Bill","Key","ToiletPaper"]
    let keyText : [String] = ["Take out the trash", "Clean up", "Do your dishes", "Clean out the fridge", "Lower the volume", "Clean the bathroom", "Pay your bills", "Help I'm Locked Out!", "Out of toilet paper"]
    var buttonNumber : Int = 0;
    var roommates : [PFObject]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //NSLog("%i",buttonNumber);
        pingPicture.image = UIImage(named: key[buttonNumber])
        pingLabel.text = keyText[buttonNumber];
        
        redView.layer.cornerRadius = 10;
        redView.layer.masksToBounds = true;
        
        DataManager.sharedInstance.getRoommates({roommates in
            self.roommates = roommates
            self.collectionView.reloadData()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//start of collection view
    let reuseIdentifier = "cell"
    
    // Tell the collection view how many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (roommates == nil) {
            return 0
        } else {
            return roommates!.count
        }
    }
    
    func getUserName(index : Int) -> String {
        if (roommates != nil) {
            return roommates![index]["firstName"] as! String // + (roommates![index]["lastName"] as! String)
        } else {
            return ""
        }
    }
    
    func getProfilePicture() -> UIImage {
        return UIImage(named: "UserSmall")!
    }
    
    // Make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // Get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        
        //let blue = UIColor(colorLiteralRed: 89/255.0, green: 196/255.0, blue: 197/255.0, alpha: 1.0)
        
        // Set contents and appearance of cell
        /*cell.profilePicture.layer.borderWidth = 3
        cell.profilePicture.layer.masksToBounds = false
        cell.profilePicture.layer.borderColor = blue.CGColor
        cell.profilePicture.layer.cornerRadius = cell.profilePicture.frame.height/2
        cell.profilePicture.layer.backgroundColor = blue.CGColor
        cell.profilePicture.clipsToBounds = true*/
        
        if (roommates == nil) {
            cell.nameLabel.text = ""
        } else {
            cell.nameLabel.text = getUserName(indexPath.item)
        }
        cell.profilePicture = UIImageView(image: getProfilePicture())
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        //buttonNumber
        DataManager.sharedInstance.getMessageTypes({messageTypes in
            if (messageTypes != nil) {
                DataManager.sharedInstance.createMessage(messageTypes![self.buttonNumber], toUser: self.roommates![indexPath.item], completion: {successful in
                    if (successful) {
                        
                    } else {
                        
                    }
                })
            }
        })
    }

}
