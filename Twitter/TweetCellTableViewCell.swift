//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Sheng Liu on 3/3/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favButton: UIButton!
    
    
    var favorited:Bool = false
    var retweet:Bool = false
    var tweetID:Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func retweetButtonOnTap(_ sender: Any) {
        let tobeRetweeted = !retweet
        if(tobeRetweeted){
            TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
                self.setRetweet(isRetweet: true)
            }, failure: { (Error) in
                print("Retweet did not succeed: \(Error)")
            })
        } else{
            TwitterAPICaller.client?.unretweet(tweetID: tweetID, success: {
                self.setRetweet(isRetweet: false)
            }, failure: { (Error) in
                print("Unretweet did not succeed: \(Error)")
            })
        }
        
    }
    
    @IBAction func favButtonOnTap(_ sender: Any) {
        let tobeFavorited = !favorited
        if(tobeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(isFavorited: true)
            }, failure: { (Error) in
                print("Favorite did not succeed: \(Error)")
            })
        } else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(isFavorited: false)
            }, failure: { (Error) in
                print("Unfavorite did not succeed: \(Error)")
            })
        }
    }
    
    func setFavorite(isFavorited:Bool){
        favorited = isFavorited
        if(favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweet(isRetweet:Bool){
        retweet = isRetweet
        if(retweet){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
        } else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
