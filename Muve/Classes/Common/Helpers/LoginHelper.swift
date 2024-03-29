//
//  LoginHelper.swift
//  Muve
//
//  Created by Givi Pataridze on 25/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import Foundation
import Firebase

enum LoginType: Int {
    case email = 0
    case google = 1
    case facebook = 2
}

class LoginHelper {
    
    //MARK:- Login methods
    static func login(login: String, pass: String, completion: (FIRUser?, NSError?) -> Void) {
        FIRAuth.auth()?.signInWithEmail(login, password: pass) { (user, error) in
            completion(user,error)
        }
    }
    
    static func googleLogin(idToken: String, accessToken: String,  completion: (FIRUser?, NSError?) -> Void) {
        let credential = FIRGoogleAuthProvider.credentialWithIDToken(idToken, accessToken: accessToken)
        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
            completion(user, error)
        }
    }
    
    static func authStateDidChange(completion: (FIRAuth, FIRUser?) -> Void) {
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            completion(auth, user)
        }
    }
}
