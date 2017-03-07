//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Fiona Thompson on 3/4/17.
//  Copyright © 2017 Fiona Thompson. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    


    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var user: User?
    var tweets: [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
        
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
        
        TwitterClient.sharedInstance?.userTimeline(handle: user?.screenname as! String, success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetCell
        let tweet = tweets[indexPath.row]
        let username = tweet.user?.name as String?
        if let url = tweet.profileUrl {
            cell.profilePicImageView.setImageWith(url)
        }
        cell.usernameButton.setTitle(username, for: .normal)
        cell.handleLabel.text = "@\((tweet.user?.screenname)!)"
        cell.tweetTextLabel.text = tweet.text
        cell.tweet = tweet
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
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
