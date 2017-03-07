//
//  User.swift
//  Twitter
//
//  Created by Fiona Thompson on 2/27/17.
//  Copyright © 2017 Fiona Thompson. All rights reserved.
//

import UIKit

class User: NSObject {

    var name : NSString?
    var screenname: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    var bannerUrl: NSURL?
    var tweetCount: Int?
    var followerCount: Int?
    var followingCount: Int?
    var dictionary: NSDictionary?
    
    static let userDidLogOutNotification = "userDidLogout"

    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        
        name = dictionary["name"] as? NSString
        screenname = dictionary["screen_name"] as? NSString
        
        let profileUrlString = dictionary["profile_image_url_https"] as? NSString
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString as String)
        }
        let bannerUrlString = dictionary["profile_background_image_url_https"] as? NSString
        if let bannerUrlString = bannerUrlString{
            bannerUrl = NSURL(string: bannerUrlString as String)
        }
        tagline = dictionary["description"] as? NSString
        tweetCount = dictionary["statuses_count"] as? Int
        followerCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
            
                let userData = defaults.object(forKey: "currentUserData") as? Data
            
                if let userData = userData {
                    let dictionary = try? JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    if let dictionary = dictionary {
                        _currentUser = User(dictionary: dictionary)
                    }
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user{
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            }else {
                defaults.set(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
    
    
}
