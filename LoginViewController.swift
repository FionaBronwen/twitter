//
//  LoginViewController.swift
//  Twitter
//
//  Created by Fiona Thompson on 2/21/17.
//  Copyright © 2017 Fiona Thompson. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "hDJpsYLgplUbm8EXU5R4Ukx2v", consumerSecret: "lDUpst9kAIu0eesXiT2Jfm3rGoe5T0U4vHqcQGJj0lNYvmo1q4")
        
        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: nil, scope: nil,
        success:{ (reguestToken: BDBOAuth1Credential?) in
            print("I got a token!! ")
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize")
            
        }, failure: { (NSError) in
            print("Error: \(NSError?.localizedDescription)")
        })
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
