////
////  if sorting doesnt work then.swift
////  Firebase_Insta
////
////  Created by Vishal on 08/12/23.
////
//
////
////  ViewController.swift
////  Firebase_Insta
////
////  Created by Vishal on 29/11/23.
////
//
//import UIKit
//import Firebase
//import FirebaseAuth
//
//class ViewController: UIViewController,protocolToSetBG {
//
//    @IBOutlet weak var viewForLogIN: UIView!
//    @IBOutlet var emailTxtField: UITextField!
//    @IBOutlet var emailWidthConstraint: NSLayoutConstraint!
//    @IBOutlet var passTxtField: UITextField!
//    @IBOutlet var passWidthConstraint: NSLayoutConstraint!
//    @IBOutlet var loginBtnEffect: UIButton!
//    @IBOutlet var createAccountLblEffect: UILabel!
//    @IBOutlet var signUpBtnEffect: UIButton!
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setUpUI()
//    }
//
//    private func setUpUI(){
//        setBackGroundImage(imageName: "AppBG")
//        viewForLogIN.layer.cornerRadius = 25.0
//        emailWidthConstraint.constant = 260
//        passWidthConstraint.constant = 260
//    }
//
//
//    func animatingTextFields(){
//        print("animatingTextFields called---")
//        UIView.animate(withDuration: 3.0) {
//            self.emailWidthConstraint.constant = 30
//            self.passWidthConstraint.constant = 30
//            self.view.layoutIfNeeded()
//        }
//    }
//
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        if let userEmail = UserDefaults.standard.string(forKey: "userEmail"),
//                let userPassword = UserDefaults.standard.string(forKey: "userPassword") {
//                // User imputs are saved, to logging in
//                Firebase.Auth.auth().signIn(withEmail: userEmail, password: userPassword) { [weak self] result, error in
//                    guard let strongSelf = self else { return }
//
//                    if error == nil {
//                        // Successfully logged in
//                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                        let tableViewController = storyboard.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
//
//                        strongSelf.navigationController?.pushViewController(tableViewController, animated: true) ?? strongSelf.present(tableViewController, animated: true, completion: nil)
//                    } else {
//                        // Handling error, e.g., showing login screen alert
//                        strongSelf.showCreateAccountFunc()
//                    }
//                }
//            } else {
////                Animation is here
//                self.viewForLogIN.alpha = 0.0
//                UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseInOut, animations: {
//                    self.viewForLogIN.alpha = 1.0
//                }) { (completed) in
//                    if completed {
//                        print("Animation completed")
//                        self.animatingTextFields()
//                    } else {
//                        print("Animation interrupted")
//                    }
//                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//                    self.animatingTextFields()
//                }
//            }
//    }
//
//
//
//    @IBAction func logInBTN(_ sender: UIButton) {
//        print("logInBTN tapped-----")
//
//        UserDefaults.standard.set("example@email.com", forKey: "userEmail")
//        if let userEmail = UserDefaults.standard.value(forKey: "userEmail") as? String {
//            print("userEmail-- \(userEmail)")
//        } else {
//            print("User email not found in UserDefaults.")
//        }
//
//
//        guard let email = emailTxtField.text, !email.isEmpty,
//              let password = passTxtField.text, !password.isEmpty else{
//            print("Missing Field data")
//            return
//        }
//
//        showAlertForSaveDataInUserDefaults(email: email, password: password) {
//            Firebase.Auth.auth().signIn(withEmail: email, password: password) { [weak self] Result, error in
//
//                guard let strongSelf = self else {
//                    return
//                }
//
//                guard error == nil else {
//                    strongSelf.showCreateAccountFunc()
//                    return
//                }
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let TableViewController = storyboard.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
//
//                strongSelf.navigationController?.pushViewController(TableViewController, animated: true) ?? strongSelf.present(TableViewController, animated: true, completion: nil)
//
//            }
//        }
//
//    }
//
//    func showCreateAccountFunc(){
//        print("showCreateAccountFunc called----")
//        let alert = UIAlertController(title: "Invalid user", message: "Tap sign in to create an account", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
//
//        DispatchQueue.main.async {
//            self.present(alert, animated: true, completion: nil)
//        }
//    }
//
//    @IBAction func SignUPBTN(_ sender: UIButton) {
//        print("SignUPBTN tapped-----")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let secondViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
//
//        navigationController?.pushViewController(secondViewController, animated: true) ?? present(secondViewController, animated: true, completion: nil)
//
//    }
//
//}
//
//extension UIViewController {
//    func showAlertForSaveDataInUserDefaults(email: String, password: String, completion: @escaping () -> Void) {
//            let alertController = UIAlertController(title: "Save Data", message: "Do you want to save your login credentials?", preferredStyle: .alert)
//
//            let saveAction = UIAlertAction(title: "Yes", style: .default) { [weak self] (action) in
//                self?.saveUserData(email: email, password: password)
//                self?.printConfirmationMessage()
////                self?.naivgationOnAlert()
//                completion()
//            }
//
//            let continueAction = UIAlertAction(title: "No", style: .default) { _ in
////                self.naivgationOnAlert()
//                completion()
//            }
//
//            alertController.addAction(saveAction)
//            alertController.addAction(continueAction)
//
//            present(alertController, animated: true, completion: nil)
//        }
//
//        func printConfirmationMessage() {
//            print("User login credentials saved to UserDefaults.")
//
//            // Additional print statements to check if data is added
//            if let savedEmail = UserDefaults.standard.string(forKey: "userEmail"),
//               let savedPassword = UserDefaults.standard.string(forKey: "userPassword") {
//                print("Saved Email: \(savedEmail)")
//                print("Saved Password: \(savedPassword)")
//            } else {
//                print("Error retrieving saved data from UserDefaults.")
//            }
//        }
//
//        func saveUserData(email: String, password: String) {
//            UserDefaults.standard.set(email, forKey: "userEmail")
//            UserDefaults.standard.set(password, forKey: "userPassword")
//        }
//
//    func naivgationOnAlert(){
//        let storyboard = TableViewController()
//        self.navigationController?.pushViewController(storyboard, animated: true)
//    }
//
//}
//
//
//
//
