//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Alberto Nencioni on 02/27/18.
//  Copyright © 2018 Alberto Nencioni. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, TweetCellUpdater {
  
  var tweets: [Tweet] = []
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.separatorInset = .zero
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 100
    
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
    tableView.insertSubview(refreshControl, at: 0)
    
    APIManager.shared.getHomeTimeLine { (tweets, error) in
      if let tweets = tweets {
        self.tweets = tweets
        self.tableView.reloadData()
      } else if let error = error {
        print("Error getting home timeline: " + error.localizedDescription)
      }
    }
  }
  
  func updateTableView() {
    tableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
    cell.delegate = self
    cell.tweet = tweets[indexPath.row]
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  var isMoreDataLoading = false
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if (!isMoreDataLoading) {
      // Calculate the position of one screen length before the bottom of the results
      let scrollViewContentHeight = tableView.contentSize.height
      let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
      
      // When the user has scrolled past the threshold, start requesting
      if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
        isMoreDataLoading = true
        // MARK: TODO: Reload more tweets for infinite scrolling
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func didTapLogout(_ sender: Any) {
    APIManager.shared.logout()
  }
  
  @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
    APIManager.shared.getHomeTimeLine { (tweets, error) in
      if let tweets = tweets {
        self.tweets = tweets
        self.tableView.reloadData()
      } else if let error = error {
        print("Error getting home timeline: " + error.localizedDescription)
      }
    }
    refreshControl.endRefreshing()
  }
  
}
