//
//  tweetCellTableViewCell.swift
//  Twitter
//
//  Created by Emira Hajj on 10/8/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class tweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var heartButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweetId:Int = -1
    var favorited:Bool = false;
    
    @IBAction func retweetTweet(_ sender: Any) {
        
    }
    

    @IBAction func likeTweet(_ sender: Any) {
        let tobeFavorited = !favorited
        
        if (tobeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: {(error) in
                print("Favorite did not succeed:\(error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: {(error) in
                print("Unfavorite did not succeed:\(error)")
            })
        }
        
    }

    
    func setFavorite(_ isFavorited: Bool) {
        favorited = isFavorited
        if (favorited) {
            heartButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            heartButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
