//
//  homeViewController.swift
//  login-logout
//
//  Created by Gokul Nair on 23/05/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import UIKit
import Firebase

class homeViewController: UIViewController {
    
    
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var moreButton: UIImageView!
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var emailTextField: UILabel!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK:- TO MAKE THE IMAGE TAPDESTURE ON
              let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(homeViewController.infoButton(tapgesture:)))
              moreButton.isUserInteractionEnabled = true
              moreButton.addGestureRecognizer(tapGesture)
        
        //MARK:- TO RECAL DATA FROM DATA BASE
        self.loadData()
    }
    
    //MARK:- signout task
    
    @IBAction func logOut(_ sender: UIButton) {
    
    
    
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
        
  //MARK:- IMAGE GESTURE TO GET INTO MORE INFO
    
    @objc func infoButton(tapgesture: UITapGestureRecognizer){
        performSegue(withIdentifier: "profileToInfo", sender: self)
    }
    
    func loadData() {
        
        db.collection(HooP.FStore.collectionname).getDocuments{(querySnapshot, error) in
        if let e = error
        {
            print("the data is not displayed due to \(e)")
        }
        else {
            
            
            if let snapshotdDocuments = querySnapshot?.documents{
                for doc in snapshotdDocuments{
                    let data = doc.data()
                    if let user = data[HooP.FStore.userName] as? String,let ID = data[HooP.FStore.emailId] as? String{
                        
                        self.nameTextField.text = user
                        self.emailTextField.text = ID
                        
                    }
              }
            }
          }
        }
    }
 
}


