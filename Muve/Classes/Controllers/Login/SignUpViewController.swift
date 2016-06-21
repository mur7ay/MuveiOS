//
//  SignUpViewController.swift
//  Muve
//
//  Created by Givi Pataridze on 22/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtPassConfirm: UITextField!
    @IBOutlet weak var btnAlreadyRegistered: UIButton!
    @IBOutlet weak var lblTermsPrivacy: TTTAttributedLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupButtons()
        setupTxtFields()
        setupAttributedLabel()
    }
    
    func setupButtons() {
        btnSignUp.customBorder(borderWidth: 1, borderColor: UIColor.whiteColor(), normalColor: UIColor.clearColor(), highlightedColor: Colors.loginButtonPressed)
        btnSignUp.layer.cornerRadius = CGFloat(8)
    }
    
    func setupTxtFields() {
        txtEmail.delegate = self
        txtPass.delegate = self
        txtPassConfirm.delegate = self
        txtEmail.layer.cornerRadius = CGFloat(8)
        txtPass.layer.cornerRadius = CGFloat(8)
        txtPassConfirm.layer.cornerRadius = CGFloat(8)
        txtEmail.leftView = UIView(frame: CGRectMake(0, 0, 15, txtEmail.frame.height))
        txtEmail.leftViewMode = .Always
        txtPass.leftView = UIView(frame: CGRectMake(0, 0, 15, txtPass.frame.height))
        txtPass.leftViewMode = .Always
        txtPassConfirm.leftView = UIView(frame: CGRectMake(0, 0, 15, txtPassConfirm.frame.height))
        txtPassConfirm.leftViewMode = .Always
    }
    
    func setupAttributedLabel() {
        let text: NSString = "By joining you agree our Terms and Privacy Policy"
        lblTermsPrivacy.text = text as String
        lblTermsPrivacy.textColor = UIColor.whiteColor()
        lblTermsPrivacy.delegate = self
        let terms: NSRange = text.rangeOfString("Terms")
        lblTermsPrivacy.addLinkToURL(NSURL(string: "Terms"), withRange: terms)
        let policy: NSRange = text.rangeOfString("Privacy Policy")
        lblTermsPrivacy.addLinkToURL(NSURL(string: "Privacy Policy"), withRange: policy)
    }
}

extension SignUpViewController: TTTAttributedLabelDelegate {

    func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!) {
        if let text = url {
            switch text.absoluteString {
            case "Terms":
                break
                //open Terms
            case "Private Policy":
                break
                //open Policy
            default:
                return
            }
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        switch textField {
        case txtEmail:
            txtEmail.text = ""
        case txtPass:
            txtPass.text = ""
            txtPass.secureTextEntry = true
        case txtPassConfirm:
            txtPassConfirm.text = ""
            txtPassConfirm.secureTextEntry = true
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
        case txtPassConfirm:
            if txtPassConfirm.text == "" {
                txtPassConfirm.secureTextEntry = false
                txtPassConfirm.text = "Confirm Password"
            }
        default:
            return
        }
    }
}