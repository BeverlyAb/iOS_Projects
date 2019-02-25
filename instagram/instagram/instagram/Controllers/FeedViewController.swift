//
//  FeedViewController.swift
//  instagram
//
//  Created by Beverly Abadines on 2/19/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class FeedViewController: UIViewController, MessageInputBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    var posts = [PFObject]()
    let refreshController = UIRefreshControl()
    
    let commentBar = MessageInputBar()
    var showsCommentBar = false
    
    var selectedPost : PFObject!
    var selectedProfileImg : PFFileObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        refreshController.addTarget(self, action: #selector(viewDidAppear), for: .valueChanged)
        tableView.refreshControl = refreshController
        
        tableView.keyboardDismissMode = .interactive
        
        
        //config commentbar
        commentBar.inputTextView.placeholder = "Add a comment..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
        
        //broadcasts notifications
        let center = NotificationCenter.default
        //self = viewController
        //selector = name of function called
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        
        //query
        let query = PFQuery(className: "Posts")
        query.includeKeys(["author", "comments","comments.author"])///fetches obj from pointer
        query.limit = 20
        
        //store data
        query.findObjectsInBackground{(posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            } else{
                self.createAlert(title: "Error", message: "\(error!.localizedDescription)")
            }
        }
        self.refreshController.endRefreshing()
    }
    //-------------------- message text bar ---------------------------
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        //create the comment
        let comment = PFObject(className: "Comments")
        comment["text"] = text
        comment["post"] = selectedPost
        comment["author"] = PFUser.current()!

        selectedPost.add(comment, forKey: "comments")
        selectedPost.saveInBackground{(success, error) in
            if (success){
                //self.createAlert(title: "Success", message: "Comment Saved")
                print("Comment Saved")
            } else{
                self.createAlert(title: "Uh oh", message: "\(error?.localizedDescription)")
            }

        }
        tableView.reloadData()
        
        //clear and dismiss input bar
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }
    
    override var inputAccessoryView: UIView?{
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool{
        return showsCommentBar
    }
    
    @objc func keyboardWillBeHidden(note: Notification){
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
    }
    //--------------------- logout -----------------------------------
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = loginViewController
    }
    
    
    //------------------------Error Message  -------------
    func createAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert,animated: true, completion: nil)
    }
    
}


extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        //postCell
        if (indexPath.row == 0) {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as! FeedTableViewCell
        
            let user = post["author"] as! PFUser
            cell.authorLabel.text = user.username
            cell.captionLabel.text = post["caption"] as? String
            
            if(post["image"] as? PFFileObject != nil){
                let imgFile = post["image"] as! PFFileObject
                let urlStr = imgFile.url!
                let  url = URL(string: urlStr)!
                cell.photoImg.af_setImage(withURL: url)
                
            }
            if(post["profile"] as? PFFileObject != nil){
                let proFile = post["profile"] as! PFFileObject
//                if(selectedProfileImg != nil){
//                    proFile = selectedProfileImg!
//                    print("dang")
//                }
                
                let urlStr = proFile.url!
                let  url = URL(string: urlStr)!
                cell.profileImg.af_setImage(withURL: url)
            }
            return cell
        } else if (indexPath.row <= comments.count){ // commentCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
            let comment = comments[indexPath.row - 1]
            let user = comment["author"] as! PFUser
            cell.authorLabel.text = user.username
            
            cell.commentLabel.text = comment["text"] as? String
//
//            if(selectedProfileImg != nil){
//
//                let proFile = selectedProfileImg!
//                print("yo \(proFile)")
//                let urlStr = proFile.url!
//                let  url = URL(string: urlStr)!
//                cell.proImg.af_setImage(withURL: url)
//            }
            
            return cell
        } else { //addCommmentCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell") as! AddCommentCell
                
            let profileVC = ProfileViewController()
            selectedProfileImg = profileVC.selectedProfileImgz
            if(selectedProfileImg != nil){
                let proFile = selectedProfileImg!
                let urlStr = proFile.url!
                let  url = URL(string: urlStr)!
                cell.profileImg.af_setImage(withURL: url)
            }
                
              
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.section]
        
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        if(indexPath.row == comments.count + 1){
            showsCommentBar = true
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
            
            selectedPost = post
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let post = posts[section]
        //optional = if nil then it takes on []
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        return comments.count + 2 // postCell + addCommentCell
    }
}

