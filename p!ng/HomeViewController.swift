//
//  HomeViewController.swift
//  p!ng
//
//  Created by Yuna Lee on 2/27/16.
//  Copyright © 2016 yakk. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var homeNameLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func inviteEmail(sender: AnyObject) {
        //Segue to a view with a text label
        //and a list
    }
    
    let reuseIdentifier = "cell"
    var roommates : [PFObject]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.sharedInstance.getHome({home in
            if (home != nil) {
                self.homeNameLabel.text = home!["name"] as! String?
            } else {
                self.homeNameLabel.text = "E Icon Plaza"
            }
        })
        DataManager.sharedInstance.getRoommates({roommates in
            self.roommates = roommates
            self.collectionView.reloadData()
        })
    }
    
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
        
       /* let blue = UIColor(colorLiteralRed: 89/255.0, green: 196/255.0, blue: 197/255.0, alpha: 1.0)
        
        // Set contents and appearance of cell
        cell.profilePicture.layer.borderWidth = 3
        cell.profilePicture.layer.masksToBounds = false
        cell.profilePicture.layer.borderColor = blue.CGColor
        cell.profilePicture.layer.cornerRadius = cell.profilePicture.frame.height/2
        cell.profilePicture.layer.backgroundColor = blue.CGColor
        cell.profilePicture.clipsToBounds = true*/
        if (roommates == nil) {
            cell.nameLabel.text = ""
        } else {
            cell.nameLabel.text = getUserName(indexPath.row)
        }
        cell.profilePicture = UIImageView(image: getProfilePicture())
        
        return cell
    }
}