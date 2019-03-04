//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Sheng Liu on 3/1/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var tweetArray = [NSDictionary]()
    var numberOfTweet: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }

    @objc func loadTweets(){
        numberOfTweet = 20
        
        let twitterUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count" : numberOfTweet]
        TwitterAPICaller.client?.getDictionariesRequest(url: twitterUrl, parameters: params, success:
            { (tweets : [NSDictionary]) in
            
                self.tweetArray.removeAll()
                for tweet in tweets {
                    self.tweetArray.append(tweet)
                }
                
                self.tableView.reloadData()
                // end the freshment
                self.myRefreshControl.endRefreshing()
                
        }, failure: { (Error) in
            print("Couldn't retrieve tweet")
        })
    }
    
    func loadMoreTweets(){
        let twitterUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweet = numberOfTweet + 20;
        let params = ["count" : self.numberOfTweet]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: twitterUrl, parameters: params, success:
            { (tweets : [NSDictionary]) in
                
                self.tweetArray.removeAll()
                for tweet in tweets {
                    self.tweetArray.append(tweet)
                }
                
                self.tableView.reloadData()
              
           
                
        }, failure: { (Error) in
            print("Couldn't retrieve tweet")
        })
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets()
        }
    }
    
    @IBAction func logoutOnTap(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCellTableViewCell
        
        
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        let imageUrl = URL(string: (user["profile_image_url_https"])! as! String)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }
    
    
}
