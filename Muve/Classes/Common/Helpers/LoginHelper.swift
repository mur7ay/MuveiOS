//
//  LoginHelper.swift
//  Muve
//
//  Created by Givi Pataridze on 25/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import Foundation
import Firebase
import KeychainSwift

enum LoginType: Int {
    case email = 0
    case google = 1
    case facebook = 2
}

class LoginHelper {
    
    //MARK:- Keychain methods
    static func getLoginType() -> LoginType? {
        guard let loginType = UserDefaulsHelper.getLoginType() else { return nil }
        return loginType
    }
    
    static func getKeyChainLogin() -> (String, String)? {
        guard let login = KeychainSwift().get(Keychain.loginKey) where login != "" else { return nil }
        guard let pass = KeychainSwift().get(Keychain.passKey) where pass != "" else { return nil }
        return (login,pass)
    }
    
    static func setKeyChainLogin(token: (String,String)) -> Bool {
        guard KeychainSwift().set(token.0, forKey: Keychain.loginKey) &&
            KeychainSwift().set(token.1, forKey: Keychain.passKey) else { return false }
        UserDefaulsHelper.setLoginType(.email)
        return true
    }
    
    static func setKeyChainTokenGoogle(token: (String,String)) -> Bool {
        guard KeychainSwift().set(token.0, forKey: Keychain.tokenGoogle) &&
            KeychainSwift().set(token.1, forKey: Keychain.tokenAccessGoogle) else { return false }
        UserDefaulsHelper.setLoginType(.google)
        return true
    }
    
    static func setKeyChainTokenFacebook(token: (String,String)) -> Bool {
        guard KeychainSwift().set(token.0, forKey: Keychain.tokenFacebook) &&
            KeychainSwift().set(token.1, forKey: Keychain.tokenAccessFacebook) else { return false }
        UserDefaulsHelper.setLoginType(.facebook)
        return true
    }
    
    static func getKeyChainTokenGoogle() -> (String,String)? {
        guard let token = KeychainSwift().get(Keychain.tokenGoogle) where token != "" else { return nil }
        guard let accessToken = KeychainSwift().get(Keychain.tokenAccessGoogle) where accessToken != "" else { return nil }
        return (token,accessToken)
    }
    
    static func getKeyChainTokenFacebook() -> (String,String)? {
        guard let token = KeychainSwift().get(Keychain.tokenFacebook) where token != "" else { return nil }
        guard let accessToken = KeychainSwift().get(Keychain.tokenAccessFacebook) where accessToken != "" else { return nil }
        return (token,accessToken)
    }
    
    static func removeKeyChains() {
        KeychainSwift().delete(Keychain.loginKey)
        KeychainSwift().delete(Keychain.passKey)
        KeychainSwift().delete(Keychain.tokenGoogle)
        KeychainSwift().delete(Keychain.tokenAccessGoogle)
        KeychainSwift().delete(Keychain.tokenFacebook)
        KeychainSwift().delete(Keychain.tokenAccessFacebook)
        UserDefaulsHelper.removeLoginType()
    }
    
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
    
    static func signOut() {
        LoginHelper.removeKeyChains()
    }
    
    /*
    static func facebookLogin(idToken: String, accessToken: String,  completion: (FIRUser?, NSError?) -> Void) {
        let credential = FIRGoogleAuthProvider.credentialWithIDToken(idToken, accessToken: accessToken)
        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
            completion(user, error)
        }
    }
     */
    
    static func validate() {
    FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
        if let _ = user {
            // User is signed in.
        } else {
            // No user is signed in.
        }
    }

    }

}