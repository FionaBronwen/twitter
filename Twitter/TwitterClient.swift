//
//  TwitterClient.swift
//  Twitter
//
//  Created by Fiona Thompson on 2/27/17.
//  Copyright © 2017 Fiona Thompson. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "hDJpsYLgplUbm8EXU5R4Ukx2v", consumerSecret: "lDUpst9kAIu0eesXiT2Jfm3rGoe5T0U4vHqcQGJj0lNYvmo1q4")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> () ) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitter://oauth") as URL!, scope: nil, success:{ (requestToken: BDBOAuth1Credential?) in
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            UIApplication.shared.open(url as URL)
                                                            
        }, failure: { (error: Error?) in
                print("Error: \(error?.localizedDescription)")
                self.loginFailure?(error!)
            })
    }
    
    func tweet(status: String){
        let endpoint = "/1.1/statuses/update.json?status="
        guard let encocdedStatus = status.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        let url = endpoint + encocdedStatus
        post(url, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            print("Successful tweet!!!!!!!!!")
        }) { (task:URLSessionDataTask?, error: Error) in
            print("error:\(error.localizedDescription)")
        }
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogOutNotification), object: nil)
    }
    
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            
            self.currentAccount(success: { (user: User) in
                User.currentUser = user //calls setter and saves user
                self.loginSuccess?()
            }, failure: { (error:Error) in
                self.loginFailure?(error)
            })
            
            }, failure: { (error: Error?) in
            print("error: \(error?.localizedDescription)")
                self.loginFailure!(error!)
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            
            let userDictionary = response as? NSDictionary
            let user = User(dictionary: userDictionary!)
            success(user)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("error: \(error.localizedDescription)")
            failure(error)
        })
    }

    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil,
            success: { (task:URLSessionDataTask, response: Any?) in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
            
        })


    
}
}
