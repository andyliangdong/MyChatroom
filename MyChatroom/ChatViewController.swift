//
//  ChatViewController.swift
//  MyChatroom
//
//  Created by Andy (Liang) Dong on 9/9/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //var messages = [PFObject]()
    var messages : [PFObject]?
    
    @IBOutlet weak var messageTextInput: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onSend(sender: AnyObject) {
        
        var myMessage = PFObject(className:"Message")
        
        
        myMessage["text"] = messageTextInput.text!
        myMessage["user"] = PFUser.currentUser()
        
        myMessage.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if (success){
                //self.messages.append(myMessage)
                println(myMessage["text"])
            } else {
                println("message save failed \(error?.description)")
            }
        }
        
        
    }
    
    func onTimer() {
        retrieveMessages()
    }

    
    func retrieveMessages(){
        
        var query = PFQuery(className:"Message")
        query.orderByDescending("createdAt")
        query.includeKey("user")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    self.messages = objects
                    self.tableView.reloadData()
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = messages {
            return messages.count
        } else {
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as! MessageCell
        
        let message = messages![indexPath.row]
        let text = message["text"] as! String
        cell.messageTextLabel?.text = text
        
        
        let user = message["user"] as? PFUser
        cell.messageUserLabel?.text = (user?.username ?? "") as String
      
        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
