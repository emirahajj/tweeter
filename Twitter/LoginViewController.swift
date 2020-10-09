//
//  LoginViewController.swift
//  Twitter
//
//  Created by Emira Hajj on 10/7/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.layer.cornerRadius = 9

        // Do any additional setup after loading the view.
    }
    //when this screen appears were going to be checking whether or not the user is already
    //logged in
    override func viewDidAppear(_ animated: Bool) {
        //this is the key we arbitrarily named in the loginButton function
        //if that boolean is true then we run the segue instead of prompting for the login
        if(UserDefaults.standard.bool(forKey: "userLoggedin") == true){
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }

    @IBAction func loginButton(_ sender: Any) {
        let my_url = "https://api.twitter.com/oauth/request_token"
         
        
        UserDefaults.standard.set(true, forKey: "userLoggedin")
        
        TwitterAPICaller.client?.login(url: my_url, success: {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (Error) in
            print("could not login")
        })
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
