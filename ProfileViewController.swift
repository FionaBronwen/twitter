//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Fiona Thompson on 3/4/17.
//  Copyright © 2017 Fiona Thompson. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = user?.profileUrl {
            self.profileImageView.setImageWith(url as URL)
        }
        if let bannerUrl = user?.bannerUrl{
            self.bannerImageView.setImageWith(bannerUrl as URL)
        }
        tweetCountLabel.text = "\((user?.tweetCount)!)"
        // Do any additional setup after loading the view.
        followersCountLabel.text = "\((user?.followerCount)!)"
        followingCountLabel.text = "\((user?.followingCount)!)"
        usernameLabel.text = user?.name as String?
        handleLabel.text = "@\((user?.screenname)!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
