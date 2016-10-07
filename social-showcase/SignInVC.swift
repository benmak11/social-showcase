//
//  SignInVC.swift
//  social-showcase
//
//  Created by Baynham Makusha on 10/2/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passwordField: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("BEN: ID Found in Keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func facebookBtnTapped(_ sender: AnyObject) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("BEN : Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("BEN: User cancelled Facebook authentication")
            } else {
                print("BEN: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("BEN: Unable to authenticate with Firebase using Facebook- \(error)")
            } else {
                print("BEN: Successfully authenticated with Firebase using Facebook")
                if let user = user {
                    self.completSignIn(id: user.uid)
                }
            }
        })
    }

    @IBAction func signInTapped(_ sender: AnyObject) {
        
        if let email = emailField.text, let password = passwordField.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                
                if error == nil {
                    print("BEN: Email User authenticated with Firebase")
                    if let user = user {
                        self.completSignIn(id: user.uid)
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("BEN: Email user unable to authenticate with Firebase")
                        } else {
                            print("BEN: Email user successfully authenticated with Firebase")
                            if let user = user {
                                self.completSignIn(id: user.uid)
                            }
                        }
                    })
                }
            })
        }
    }
    
    func completSignIn(id: String) {
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("BEN: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
}

