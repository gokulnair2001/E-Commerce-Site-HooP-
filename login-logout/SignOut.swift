//
//  SignOut.swift
//  login-logout
//
//  Created by Gokul Nair on 24/05/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import Foundation
import Firebase

extension homeViewController{
    
    func SignOut() {
        let firebaseAuth = Auth.auth()
        do {
            // Deleting all user Defaults
            if let appDomain = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: appDomain)
            }
            
            // try signout
            try firebaseAuth.signOut()
           // GIDSignIn.sharedInstance().signOut()
            print("SIGN OUT")
            
            // return to home
                // let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! UINavigationController
            //self.present(vc, animated: true, completion: nil)
            let welcomeVC = ViewController()
            let welcomeNVC = UINavigationController(rootViewController: welcomeVC)
            self.present(welcomeNVC, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
