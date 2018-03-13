//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Alberto on 3/11/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import ActiveLabel

class DetailViewController: UIViewController {
  
  var tweet: Tweet!
  
  // Profile image
  @IBOutlet weak var profileImageView: UIImageView! {
    didSet {
      profileImageView.layer.cornerRadius = 3.0
    }
  }
  
  // Buttons
  @IBOutlet weak var retweetButton: UIButton!
  @IBOutlet weak var favoriteButton: UIButton!
  
  // Labels
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var screenNameLabel: UILabel!
  @IBOutlet weak var createdAtLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: ActiveLabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var favoriteCountLabel: UILabel!
  @IBOutlet weak var repliesCountLabel: UILabel!
  
  // Icons
  let retweet_def: UIImage = #imageLiteral(resourceName: "retweet-icon")
  let retweet_sel: UIImage = #imageLiteral(resourceName: "retweet-icon-green")
  let favorite_def: UIImage = #imageLiteral(resourceName: "favor-icon")
  let favorite_sel: UIImage = #imageLiteral(resourceName: "favor-icon-red")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    nameLabel.text = tweet.user?.name
    let screenName = (tweet.user?.screenName)!
    screenNameLabel.text = "@\(screenName)"
    createdAtLabel.text = tweet.createdAtString
    tweetTextLabel.numberOfLines = 0
    tweetTextLabel.enabledTypes = [.mention, .hashtag, .url]
    tweetTextLabel.text = tweet.text
    retweetCountLabel.text = String(tweet.retweetCount!)
    favoriteCountLabel.text = String(tweet.favoriteCount!)
    
    profileImageView.af_setImage(withURL: URL(string: (tweet.user?.profileImgURL)!)!)
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
