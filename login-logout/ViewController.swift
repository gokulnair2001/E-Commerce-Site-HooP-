//
//  ViewController.swift
//  login-logout
//
//  Created by Gokul Nair on 23/05/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import UIKit
import Firebase
import LocalAuthentication

class ViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       emailtextField.delegate = self
       passwordTextField.delegate = self
       self.emailtextField.delegate = self
        
        authenticateUserAndConfigureView()
    }
    
   

    
    //MARK:- To authintecate when user press login button
    @IBAction func loginButton(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: emailtextField.text!, password: passwordTextField.text!){(user, error)
            in
            if error == nil
            {
                self.performSegue(withIdentifier: "toHome", sender: nil)
                self.clear()
            }
            else
            {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .actionSheet)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                    
                alert.addAction(defaultAction)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
  
  //MARK:- TO CLEAR DATA ONCE SIGNED IN
    
    func clear() {
        self.emailtextField.text?.removeAll()
        self.passwordTextField.text?.removeAll()
    }
    
    //MARK:- TO CHECK WETHER USER IS STILL SIGNED IN OR NOT
       
       func authenticateUserAndConfigureView()
       {
        if Auth.auth().currentUser != nil{
           let context:LAContext = LAContext()
                  
                  if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
                  {
                      context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Message") { (True, error) in
                          if True
                          {
                            
                             print("sucess")
                              DispatchQueue.main.async {
                                self.navigationController?.isNavigationBarHidden = false
                                  
                                  self.performSegue(withIdentifier: "toHome", sender: nil)
                                
                              }
                             
                          }
                          else
                          {
                              print(error)
                          }
                      }
        }else{
            print("stay")
        }
        }

 
    

        //MARK:- Hide Keyboard
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
               self.view.endEditing(true)
           }
           
           //hide keyboard by return key
           func textFieldShouldReturn(_ textField: UITextField) -> Bool {
               emailtextField.resignFirstResponder()
               passwordTextField.resignFirstResponder()
               return true
           }

   
}



}

