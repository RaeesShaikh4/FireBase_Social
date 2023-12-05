//
//  ViewController.swift
//  Firebase_Insta
//
//  Created by Vishal on 29/11/23.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController,protocolToSetBG {
    
    @IBOutlet weak var viewForLogIN: UIView!
    
    @IBOutlet var emailTxtField: UITextField!
    
    @IBOutlet var passTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackGroundImage(imageName: "AppBG")
        viewForLogIN.layer.cornerRadius = 25.0
    }

    @IBAction func logInBTN(_ sender: UIButton) {
        print("logInBTN tapped-----")
        guard let email = emailTxtField.text, !email.isEmpty,
              let password = passTxtField.text, !password.isEmpty else{
            print("Missing Field data")
            return
        }
        
        Firebase.Auth.auth().signIn(withEmail: email, password: password) { [weak self] Result, error in
            
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                strongSelf.showCreateAccountFunc()
                return
            }
            print("you have signed in.....")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let TableViewController = storyboard.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController

            strongSelf.navigationController?.pushViewController(TableViewController, animated: true) ?? strongSelf.present(TableViewController, animated: true, completion: nil)

        }
    }
    
    func showCreateAccountFunc(){
        print("showCreateAccountFunc called----")
        let alert = UIAlertController(title: "Invalid user", message: "Tap sign in to create an account", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
           
          
           DispatchQueue.main.async {
               self.present(alert, animated: true, completion: nil)
           }
    }
    
    @IBAction func SignUPBTN(_ sender: UIButton) {
        print("SignUPBTN tapped-----")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController

        navigationController?.pushViewController(secondViewController, animated: true) ?? present(secondViewController, animated: true, completion: nil)

        
    }
    
}


