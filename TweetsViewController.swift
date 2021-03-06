//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Fiona Thompson on 2/27/17.
//  Copyright © 2017 Fiona Thompson. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ProfileViewSegueDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    var tweets: [Tweet] = []
    var userForSegue: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(fetchTweets), for: .valueChanged)
        tableView.addSubview(refreshControl)
                
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        imageView.image = UIImage(named: "TwitterLogoBlue")
        imageView.contentMode = .scaleAspectFit
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
        self.navigationItem.titleView = titleView
        
        fetchTweets()
        

        // Do any additional setup after loading the view.
    }
    
    func fetchTweets() {
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    func profileImageTapped(user: User){
        userForSegue = user
        performSegue(withIdentifier: "ProfileViewSegue", sender: UIImageView())
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogOutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
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
        cell.retweetCountLabel.text = "\(tweet.retweetCount)"
        cell.favoriteCountLabel.text = "\(tweet.favoriteCount)"
        cell.tweet = tweet
        cell.delegate = self
        
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailvc = segue.destination as? DetailViewController
        let profilevc = segue.destination as? ProfileViewController
        
        if let sender = sender as? TweetCell {
            let indexPath = tableView.indexPath(for: sender)
            let tweet = tweets[(indexPath?.row)!]
            detailvc?.tweet = tweet //send tweet to DetailViewController
        }
        if let sender = sender as? UIImageView {
            profilevc?.user = userForSegue

        }
        
        
        
        
    }
    

}
