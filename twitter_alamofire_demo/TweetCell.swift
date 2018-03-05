//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Alberto Nencioni on 02/27/18.
//  Copyright © 2018 Alberto Nencioni. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
  
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var screenNameLabel: UILabel!
  @IBOutlet weak var createdAtLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var favoriteCountLabel: UILabel!
  @IBOutlet weak var repliesCountLabel: UILabel!
  
  var tweet: Tweet! {
    didSet {
      nameLabel.text = tweet.user?.name
      let screenName = (tweet.user?.screenName)!
      screenNameLabel.text = "@\(screenName)"
      createdAtLabel.text = tweet.createdAtString
      tweetTextLabel.text = tweet.text
      let retweetCount = tweet.retweetCount!
      let favoriteCount = tweet.favoriteCount!
      retweetCountLabel.text = String(retweetCount)
      favoriteCountLabel.text = String(favoriteCount)
      profileImageView.af_setImage(withURL: URL(string: (tweet.user?.profileImgURL)!)!)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
