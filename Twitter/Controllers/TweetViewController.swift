//
//  TweetViewController.swift
//  Twitter
//
//  Created by Beverly Abadines on 2/5/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //display keyboard and cursor
        textView.becomeFirstResponder()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postButton(_ sender: Any) {
        if (!textView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: textView.text, success: {
                self.dismiss(animated: true, completion: nil)
                
            }, failure: { (Error) in
                print("Error in posting \(Error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
