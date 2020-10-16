//
//  TweetViewController.swift
//  Twitter
//
//  Created by Emira Hajj on 10/13/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tweet(_ sender: Any) {
        if(!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: {(error) in
                print("Error posting Tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else{
            //should do an alert and say put something in and then dismiss
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.becomeFirstResponder()
        
        self.tweetTextView.layer.borderColor = UIColor.gray.cgColor
        self.tweetTextView.layer.borderWidth = 2.3
        self.tweetTextView.layer.cornerRadius = 9

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
