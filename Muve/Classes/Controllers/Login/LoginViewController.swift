//
//  LoginViewController.swift
//  Muve
//
//  Created by Givi Pataridze on 21/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, GIDSignInUIDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lineEmail: UIView!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var linePass: UIView!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignInGoogle: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        hideKeyboardWhenTappedAround()
        txtEmail.delegate = self
        txtPass.delegate = self
    }
 
    @IBAction func btnSignInGoogle(sender: AnyObject) {

    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError?) {
        if let error = error {
//            self.showMessagePrompt(error.localizedDescription)
            print("Login with google failed with error: \(error)")
            return
        }
        
        let authentication = user.authentication
        let credential = FIRGoogleAuthProvider.credentialWithIDToken(authentication.idToken,
                                                                     accessToken: authentication.accessToken)
        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
            print("user: \(user)")
            print("error: \(error)")
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        switch textField {
        case txtEmail:
            txtEmail.text = ""
            lineEmail.backgroundColor = Colors.googleBlue
        case txtPass:
            txtPass.text = ""
            linePass.backgroundColor = Colors.googleBlue
        default:
            return
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        switch textField {
        case txtEmail:
            if txtEmail.text == "" { txtEmail.text = "Email Address"}
            lineEmail.backgroundColor = UIColor.lightGrayColor()
        case txtPass:
            if txtPass.text == "" { txtPass.text = "Password"}
            linePass.backgroundColor = UIColor.lightGrayColor()
        default:
            return
        }
    }
}
