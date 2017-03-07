//
//  TweetCell.swift
//  Twitter
//
//  Created by Fiona Thompson on 2/28/17.
//  Copyright © 2017 Fiona Thompson. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var profilePicImageView: UIImageView!
    
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var usernameButton: UIButton!
    
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    var delegate: ProfileViewSegueDelegate?
    var tweet: Tweet?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        profilePicImageView.layer.cornerRadius = 3
        profilePicImageView.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped(tapGestureRecognizer:)))
        profilePicImageView.isUserInteractionEnabled = true
        profilePicImageView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    func profileImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        delegate?.profileImageTapped(user: (tweet?.user)!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        favoriteCountLabel.text = "\(Int(favoriteCountLabel.text!)! + 1)"
        favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
    }
    
    @IBAction func retweetButtonPressed(_ sender: Any) {
        retweetCountLabel.text = "\(Int(retweetCountLabel.text!)! + 1)"
        retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
    }
    
}
