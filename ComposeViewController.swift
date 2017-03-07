//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Fiona Thompson on 3/6/17.
//  Copyright © 2017 Fiona Thompson. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var tweetContentView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    
    @IBOutlet weak var tweetButton: UIBarButtonItem!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var user = User.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = user?.name as? String
        handleLabel.text = user?.screenname as? String
        if let url = user?.profileUrl {
            self.profileImageView.setImageWith(url as URL)
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tweetButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
