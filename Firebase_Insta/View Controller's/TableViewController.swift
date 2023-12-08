//
//  TableViewController.swift
//  Firebase_Insta
//
//  Created by Vishal on 04/12/23.
//

import UIKit
import FirebaseFirestore

struct Uuser{
    var uuid : String
    var name : String
    var email : String
}

class TableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var searchTxtField: UITextField!
    @IBOutlet var tableView: UITableView!
    
    var user : [Uuser] = []
    var selectedUserUUID: String?


    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchUserData()
        containerView.layer.cornerRadius = 20.0
        
    }
    
    @IBAction func searchBtn(_ sender: UIButton) {
    }
    
    
    func fetchUserData(){
        let DataBase = Firestore.firestore()
        DataBase.collection("Users").getDocuments { (querySnapShot, error) in
            if let error = error {
                print("Error while fetching data: \(error)")
            } else {
                self.user = querySnapShot?.documents.compactMap({ document in
                    let data = document.data()
//                    let uuid = data["UUID"] as? String ?? ""
                    let uuid = document.documentID
                    let name = data["name"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    return Uuser(uuid:uuid , name: name, email: email)
                    
                }) as! [Uuser]
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        let user = user[indexPath.row]
        
        cell.textLabel?.text = user.name
        let emailLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        emailLabel.text = user.email
        emailLabel.textColor = UIColor.gray
        cell.accessoryView = emailLabel
//        cell.detailTextLabel = emailLabel
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let selectedUser = user[indexPath.row]
        selectedUserUUID = selectedUser.uuid
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        homeVC.profileUserID = selectedUserUUID!
        homeVC.name = selectedUser.name
        homeVC.email = selectedUser.email
        
        self.navigationController?.pushViewController(homeVC, animated: true) ?? self.present(homeVC, animated: true, completion: nil)
    }
    
}
