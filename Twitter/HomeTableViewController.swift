//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Emira Hajj on 10/7/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numOfTweets:  Int!
    
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        
        tableView.refreshControl = myRefreshControl

    }
    
    @objc func loadTweets(){
        
        let myURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        numOfTweets = 30
        
        let myParams = ["count": numOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: myURL, parameters: myParams, success: { (tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            //end the refresher
            self.myRefreshControl.endRefreshing()

        }, failure: { (Error) in
            print("Sorry, you got an error")
        })
    }
    
    
    func loadMoreTweets(){
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        numOfTweets = numOfTweets + 20
        
        let myParams = ["count": numOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: myParams, success: { (tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            //end the refresher

        }, failure: { (Error) in
            print("Sorry, you got an error")
        })
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets()
        }
    }
    

    
    
    @IBAction func logoutButton(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        //this screen will now dismiss itself back to the login button
        //nill we don't want anything to happen once its gone
        self.dismiss(animated: true, completion: nil)
        
        UserDefaults.standard.set(false, forKey: "userLoggedin")
    }
    
    

    
    //same tableview cell setup
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! tweetCellTableViewCell
        
        let user =  tweetArray[indexPath.row]["user"] as! NSDictionary
        
        
        let imageURL = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageURL!)
        
        if let imageData = data{
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        
        
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetLabel.text = tweetArray[indexPath.row]["text"] as? String
        return cell
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

}
