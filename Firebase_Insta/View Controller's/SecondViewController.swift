//
//  SecondViewController.swift
//  Firebase_Insta
//
//  Created by Vishal on 30/11/23.
//

import UIKit
import Firebase
import FirebaseAuth

struct User {
    var uid: String
    var name: String
    var email: String
    var following: [String]
    var followers: [String]
}



class SecondViewController: UIViewController,protocolToSetBG {
    
    var currentUser: User?
    
    
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet var nameCreateTxtField: UITextField!
    
    @IBOutlet weak var emailCreateTxtField: UITextField!
    
    @IBOutlet weak var passCreateTxtField: UITextField!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackGroundImage(imageName: "AppBG")
        secondView.layer.cornerRadius = 25.0
        
    }
    
    
    @IBAction func secondLoginBTN(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func secondSignUpBtn(_ sender: UIButton) {
        
        guard let email = emailCreateTxtField.text, !email.isEmpty,
              let name = nameCreateTxtField.text, !name.isEmpty,
              let password = passCreateTxtField.text, !password.isEmpty else {
            
            print("Please enter name, email, and password.")
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
            } else {
                print("User created successfully.")
                
                guard let user = authResult?.user else {
                    print("User data is not available.")
                    return
                }
                
                let userUUID = user.uid
                
                let newUser = User(uid: userUUID, name: name, email: email, following: [], followers: [])

                self.storeUserData(user: newUser) { result in
                    switch result {
                    case .success(let storedUser):
                        print("User data stored successfully: \(storedUser)")
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let TableViewController = storyboard.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
                        
                        self.navigationController?.pushViewController(TableViewController, animated: true) ?? self.present(TableViewController, animated: true, completion: nil)
                        
                    case .failure(let storeError):
                        print("Error storing user data: \(storeError.localizedDescription)")
                    }
                }
            }
        }
        
    }
    
    func storeUserData(user: User, completion: @escaping (Result<User, Error>) -> Void) {
        let db = Firestore.firestore()
        db.collection("Users").document(user.uid).setData([
            "name": user.name,
            "email": user.email,
            "following": user.following,
            "followers": user.followers,
            "UUID": user.uid
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
}





