//
//  SignUpViewController.swift
//  login-logout
//
//  Created by Gokul Nair on 23/05/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var confirmpassText: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    let db = Firestore.firestore()
    var ref = DatabaseReference.self
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        passTextField.delegate = self
        confirmpassText.delegate = self
        
        self.nameTextField.delegate = self
        
        //MARK:- TO ACTIVATE TAPGESTURE IN IMAGE
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(SignUpViewController.openGalley(tapgesture:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGesture)
    }
    

    @IBAction func signInButton(_ sender: UIButton) {
        
          if (nameTextField.text != "" && emailTextField.text != "" && confirmpassText.text != "" && passTextField.text != "")
          {
            if let name = nameTextField.text,
                let emailid = emailTextField.text,
                let signInUser = Auth.auth().currentUser?.email{
                db.collection(HooP.FStore.collectionname).addDocument(data: [
                    HooP.FStore.userName: name,
                    HooP.FStore.emailId : emailid
                ])
                {
                    
                    (error) in
                    if let e = error {
                        print("There got some kind of issue,\(e)")
                    }
                    else{
                        print("Sucessfuly saved!!")
                        self.clear()
                     }
              }
           }
            
        
      
        //MARK:- TO CHECK CONFIRMPASS AND PASS ARE SAME OR NOT
        
        if (passTextField.text != confirmpassText.text)
        {
            let alert = UIAlertController(title: "Password-Incorrect", message: "ConfirmPassword and Password are not same", preferredStyle: .actionSheet)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        else{
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passTextField.text!){
                (user , error) in
                if error == nil {
                    self.performSegue(withIdentifier: "SignToHome", sender: nil)
                }
                else
                {
                    let alertController = UIAlertController (title: "Error",
                        message: error?.localizedDescription,
                        preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                   
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
        
    }
        else{
         
             let alertController = UIAlertController (title: "Error",
                 message: "Some Fields are empty!!",
                 preferredStyle: .alert)
             let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
             
            
             alertController.addAction(defaultAction)
             self.present(alertController, animated: true, completion: nil)
        }
}
   
//MARK:- TO OPEN GALLERRY
    @objc func openGalley(tapgesture: UITapGestureRecognizer){
      
        self.setupImagePicker()
    }
//MARK:- hide keyboard by touching out
           
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                self.view.endEditing(true)
            }
            func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                nameTextField.resignFirstResponder()
                confirmpassText.resignFirstResponder()
                emailTextField.resignFirstResponder()
                passTextField.resignFirstResponder()
                return true
    }

}



extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func setupImagePicker(){
        
        if(UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)){
            
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.isEditing = true
            imagePicker.delegate = self
         
             self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        profileImage.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- CLEAR FIELD ONCE SIGNED IN
    
    func clear() {
        self.nameTextField.text?.removeAll()
        self.confirmpassText.text?.removeAll()
        self.passTextField.text?.removeAll()
        self.emailTextField.text?.removeAll()
    }
    //MARK:- TO UPLOAD IMAGE
}
