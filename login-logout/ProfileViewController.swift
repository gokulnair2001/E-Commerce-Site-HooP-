//
//  ProfileViewController.swift
//  abseil
//
//  Created by Gokul Nair on 24/05/20.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var logOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logOut(_ sender: Any) {
        
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to Sign Out", preferredStyle: .actionSheet)
              alertController.addAction(UIAlertAction(title: "Sign Out", style: .default, handler:{(_) in
                  self.signOut()
              }))
              alertController.addAction(UIAlertAction(title: "Cancel", style:.cancel , handler: nil))
               present(alertController, animated: true,completion: nil)
        
    }
    
       func signOut(){
           do {
                      try Auth.auth().signOut()
                      navigationController?.popToRootViewController(animated: true)
                  }
                  catch let signouterror as NSError {
                      print("error found:\(signouterror)")
                  }
       }

}
