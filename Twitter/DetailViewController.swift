//
//  DetailViewController.swift
//  Twitter
//
//  Created by Fiona Thompson on 3/1/17.
//  Copyright © 2017 Fiona Thompson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = tweet{
            self.tweetLabel.text = tweet.text
            self.nameLabel.text = tweet.user?.name as String?
            self.handleLabel.text = tweet.user?.screenname as String?
            
            if let url = tweet.profileUrl {
                self.profileImageView.setImageWith(url)
            }
            self.dateLabel.text = DateFormatter.localizedString(from: tweet.timestamp!, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.short)
        }
        
        // Do any additional setup after loading the view.
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
