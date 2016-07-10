//
//  SignUpViewController.swift
//  Muve
//
//  Created by Givi Pataridze on 22/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import Firebase
import UITextField_Shake_Swift

class SignUpViewController: UIViewController, BaseViewController {

    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtPassConfirm: UITextField!
    @IBOutlet weak var btnAlreadyRegistered: UIButton!
    
    static func storyBoardName() -> String {
        return "Login"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupButtons()
        setupTxtFields()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.view.backgroundColor = UIColor.clearColor()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
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
    
    @IBAction func btnSignUp(sender: AnyObject) {
        if txtEmail.text != "" {
            if txtPass.text == txtPassConfirm.text {
                if let email = txtEmail.text, pass = txtPass.text {
                    ProgressHUD.show()
                    FIRAuth.auth()?.createUserWithEmail(email, password: pass) { (user, error) in
                        ProgressHUD.hide()
                        if let _error = error {
                            self.showSimpleAlert("Error", message: _error.localizedDescription)
                        } else {
                            if let slideMenu = LoginHelper.initSlideMenu() {
                                self.presentViewController(slideMenu, animated: true, completion: nil)
                            }
                        }
                    }
                }
            } else {
                txtPassConfirm.shake()
            }
        } else {
            txtEmail.shake()
        }
    }
    
    @IBAction func btnAlreadyRegistered(sender: AnyObject) {
        pop()
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == txtPass {
            btnSignUp(self)
            return true
        } else {
            return false
        }
    }
}