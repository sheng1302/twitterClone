//
//  LoginViewController.swift
//  Twitter
//
//  Created by Sheng Liu on 3/1/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        //loginButton.layer.borderWidth = 1
        //loginButton.layer.cornerRadius = 15
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true{
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
    

    @IBAction func onTap(_ sender: Any) {
        let urlRequestToken = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: urlRequestToken, success: {
            
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            self.performSegue(withIdentifier: "loginToHome", sender: self)
            
            
        }, failure: { (Error) in
            
            print("Error. Could not log in.")
            let title = "Error"
            let message = "An error has occured. Unable to log-in."
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        })
    }
}
