//
//  Tweet.swift
//  Twitter
//
//  Created by Fiona Thompson on 2/27/17.
//  Copyright © 2017 Fiona Thompson. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var profileUrl: URL?
    var text : String?
    var user: User?
    var timestamp : Date?
    var retweetCount : Int = 0
    var favoriteCount: Int = 0
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timeStampString = dictionary["created_at"] as? String
        
        if let timeStampString = timeStampString{
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timeStampString)
        }
        
        let profileUrlString = (dictionary["user"] as! NSDictionary)["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
         var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        return tweets
        
    }
    
}
