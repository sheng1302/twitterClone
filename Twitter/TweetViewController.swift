//
//  TweetViewController.swift
//  Twitter
//
//  Created by Sheng Liu on 3/9/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var tweetCoundownLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // makes the cursor and other stuff to be highlighted on the input box
        tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        
        var countdown = String(140 - newText.characters.count)
        self.tweetCoundownLabel.text = "Countdown: \(countdown)"
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
    }
    
    @IBAction func cancelOnTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweetOnTap(_ sender: Any) {
        
        if(!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                    self.dismiss(animated: true, completion: nil)
                }, failure:  { (Error) in
                    print("Error posting tweet \(Error)")
                    self.dismiss(animated: true, completion: nil)
                })
            
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
