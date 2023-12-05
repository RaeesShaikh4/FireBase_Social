////
////  HomeViewController.swift
////  Firebase_Insta
////
////  Created by Vishal on 30/11/23.
////
//
//import UIKit
//import Firebase
//import FirebaseFirestore
//
//class HomeViewController: UIViewController,protocolToSetBG {
//
//    @IBOutlet weak var profileImage: UIImageView!
//    @IBOutlet var nameLabel: UILabel!
//    @IBOutlet var designLabel: UILabel!
//
//    @IBOutlet var folowersCount: UILabel!
//    @IBOutlet var followingCount: UILabel!
//    //
//    var profileUserID: String = "profileUserID"
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
//        profileImage.clipsToBounds = true
//        //
//        loadFollowerFollowingCounts()
//    }
//
//    func signIn() {
//        if let user = Auth.auth().currentUser {
//            print("User authenticated.")
//        } else {
//            print("User not authenticated.")
//        }
//    }
//
//    func storeStaticDataToFirestore() {
//        let db = Firestore.firestore()
//
//        let staticData: [String: Any] = [
//            "staticField1": "Name",
//            "staticField2": "Detail",
//        ]
//
//        db.collection("Insta").addDocument(data: staticData) { error in
//            if let error = error {
//                print("Error writing document: \(error)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//    }
//
//
//    @IBAction func followButton(_ sender: UIButton) {
////        storeStaticDataToFirestore()
//        //
//        guard let currentUserID = Auth.auth().currentUser?.uid else {
//                   return
//               }
//
//               let db = Firestore.firestore()
//               let userDocRef = db.collection("users").document(currentUserID)
//
//               // Toggle follow status
//               userDocRef.getDocument { (document, error) in
//                   if let document = document, document.exists {
//                       var followingList = document.data()?["following"] as? [String] ?? []
//
//                       if followingList.contains(self.profileUserID) {
//                           // User is already following, unfollow
//                           followingList.removeAll { $0 == self.profileUserID }
//                           self.decreaseFollowersCount()
//                       } else {
//                           // User is not following, follow
//                           followingList.append(self.profileUserID)
//                           self.increaseFollowersCount()
//                       }
//
//                       // Update following list and counts in Firestore
//                       userDocRef.updateData([
//                           "following": followingList,
//                           "followingCount": followingList.count
//                       ]) { error in
//                           if let error = error {
//                               print("Error updating following list: \(error.localizedDescription)")
//                           } else {
//                               // Update UI based on the new follow status
//                               self.loadFollowerFollowingCounts()
//                           }
//                       }
//                   } else {
//                       print("Error getting user document: \(error?.localizedDescription ?? "Unknown error")")
//                   }
//               }
//    }
//
//
//    @IBAction func messageButton(_ sender: UIButton) {
//    }
//
//
//    func loadFollowerFollowingCounts() {
//            guard let currentUserID = Auth.auth().currentUser?.uid else {
//                return
//            }
//
//            let db = Firestore.firestore()
//            let userDocRef = db.collection("Users").document(currentUserID)
//
//            userDocRef.getDocument { (document, error) in
//                if let document = document, document.exists {
//                    let followersCount = document.data()?["followersCount"] as? Int ?? 0
//                    let followingCount = document.data()?["followingCount"] as? Int ?? 0
//
//                    // Update UI with counts
//                    self.folowersCount.text = "\(followersCount)"
//                    self.followingCount.text = "\(followingCount)"
//                } else {
//                    print("Error getting user document: \(error?.localizedDescription ?? "Unknown error")")
//                }
//            }
//        }
//
//
//    func increaseFollowersCount() {
//            guard let profileUserID = Auth.auth().currentUser?.uid else {
//                return
//            }
//
//            let db = Firestore.firestore()
//            let profileUserDocRef = db.collection("Users").document(profileUserID)
//
//            profileUserDocRef.updateData([
//                "followersCount": FieldValue.increment(Int64(1))
//            ]) { error in
//                if let error = error {
//                    print("Error updating followers count: \(error.localizedDescription)")
//                }
//            }
//        }
//
//        // Function to decrease the followers count
//        func decreaseFollowersCount() {
//            guard let profileUserID = Auth.auth().currentUser?.uid else {
//                return
//            }
//
//            let db = Firestore.firestore()
//            let profileUserDocRef = db.collection("Users").document(profileUserID)
//
//            profileUserDocRef.updateData([
//                "followersCount": FieldValue.increment(Int64(-1))
//            ]) { error in
//                if let error = error {
//                    print("Error updating followers count: \(error.localizedDescription)")
//                }
//            }
//        }
//}
