//
//  LoginViewController.swift
//  Muve
//
//  Created by Givi Pataridze on 21/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import Firebase
import KRProgressHUD
import Font_Awesome_Swift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignInGoogle: UIButton!
    @IBOutlet weak var btnSignInFacebook: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        setupGoogleAuth()
        setupTxtFields()
        setupButtons()
    }
    
    func setupButtons() {
        btnSignIn.customBorder(borderWidth: 1, borderColor: UIColor.whiteColor(), normalColor: UIColor.clearColor(), highlightedColor: Colors.loginButtonPressed)
        btnSignIn.layer.cornerRadius = CGFloat(8)
        btnSignInGoogle.setFAText(prefixText: "", icon: .FAGoogle, postfixText: "   Login With Google", size: 19, forState: .Normal)
        btnSignInGoogle.titleLabel?.textColor = UIColor.whiteColor()
        btnSignInFacebook.setFAText(prefixText: "", icon: .FAFacebook, postfixText: "   Login With Facebook", size: 19, forState: .Normal)
        btnSignInFacebook.titleLabel?.textColor = UIColor.whiteColor()
        
    }
    
    func setupTxtFields() {
        txtEmail.delegate = self
        txtPass.delegate = self
        txtEmail.layer.cornerRadius = CGFloat(8)
        txtPass.layer.cornerRadius = CGFloat(8)
        txtEmail.leftView = UIView(frame: CGRectMake(0, 0, 15, txtEmail.frame.height))
        txtEmail.leftViewMode = .Always
        txtPass.leftView = UIView(frame: CGRectMake(0, 0, 15, txtPass.frame.height))
        txtPass.leftViewMode = .Always
    }
    
    @IBAction func btnSignInGoogle(sender: AnyObject) {
        GIDSignIn.sharedInstance().signIn()
        KRProgressHUD.show()
    }
    
    @IBAction func btnSignInFacebook(sender: AnyObject) {
    }
    
    @IBAction func btnSignUp(sender: AnyObject) {
    }
    
    @IBAction func btnForgotPassword(sender: AnyObject) {
    }
    
    @IBAction func btnSignIn(sender: AnyObject) {
    }
}

extension LoginViewController: GIDSignInUIDelegate {
    func setupGoogleAuth() {
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        KRProgressHUD.dismiss()
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        switch textField {
        case txtEmail:
            txtEmail.text = ""
        case txtPass:
            txtPass.text = ""
            txtPass.secureTextEntry = true
        default:
            return
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        switch textField {
        case txtEmail:
            if txtEmail.text == "" {
                txtEmail.text = "Email Address"
            }
        case txtPass:
            if txtPass.text == "" {
                txtPass.secureTextEntry = false
                txtPass.text = "Password"
            }
        default:
            return
        }
    }
}

