//
//  ViewController.swift
//  MyChatroom
//
//  Created by Andy (Liang) Dong on 9/9/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
//import FBSDKCoreKit
//import FBSDKLoginKit
//import FBSDKShareKit
//import ParseFacebookUtilsV4

// email andychatroom@gmail.com
class LoginViewController: UIViewController {

    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSignUp(sender: AnyObject) {
        var user = PFUser()
        user.username = emailLabel.text
        user.password = passwordLabel.text
        user.email = emailLabel.text
        
        println(user.email)
        println(user.password)
        
        // other fields can be set just like with PFObject
        //user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
                println("failed to sign up")
            } else {
                // Hooray! Let them use the app now.
                println("sign up for email \(user.email!)")
            }
        }
    }
    
    
    @IBAction func onSignIn(sender: AnyObject) {
        let email = emailLabel.text
        let mypass = passwordLabel.text
        PFUser.logInWithUsernameInBackground(email, password:mypass) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                println("Get user \(user!.username)")
                self.performSegueWithIdentifier("tochatviewcontroller", sender: self)
            } else {
                // The login failed. Check error to see why.
                println("login fail")
            }
        }
    }

    @IBAction func onFacebookSignIn(sender: AnyObject) {
        let email = emailLabel.text
        let mypass = passwordLabel.text
        
       
        /*
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["publish_actions"]) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                if user.isNew {
                    println("User signed up and logged in through Facebook!")
                } else {
                    println("User logged in through Facebook!")
                }
            } else {
                println("Uh oh. The user cancelled the Facebook login.")
            }
        }*/
    }
}

