import UIKit
import Firebase
import FirebaseFirestore

class HomeViewController: UIViewController, protocolToSetBG{
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    @IBOutlet var followersCount: UILabel!
    @IBOutlet var followingCount: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var profileUserID: String?
    var name: String?
    var email: String?
    var loggedInUserID: String?
    var isFollowing: Bool = false
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        
        signIn()
        loadUserData()
        loadFollowerFollowingCounts()
        checkAndSetFollowStatus()
        
    }
    
    func signIn() {
        if let user = Auth.auth().currentUser {
            loggedInUserID = user.uid
            
            print("User authenticated.")
        } else {
            print("User not authenticated.")
        }
    }
    
    
    @IBAction func followButton(_ sender: UIButton) {
        
        guard let loggedInUserID = loggedInUserID, let profileUserID = profileUserID else {
                print("User not authenticated.")
                return
            }

            let userDocRef = db.collection("Users").document(profileUserID)

            // fetching the profile user's document
            userDocRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    var profileFollowers = document.data()?["followers"] as? [String] ?? []

                    if profileFollowers.contains(loggedInUserID) {
                        // User is already following, then unfollow
                        profileFollowers.removeAll { $0 == loggedInUserID }
                        self.isFollowing = false
                    } else {
                        // User is not following, then follow
                        profileFollowers.append(loggedInUserID)
                        self.isFollowing = true
                    }

                    // Updating the profile user's followers field in Firestore
                    userDocRef.updateData(["followers": profileFollowers]) { error in
                        if let error = error {
                            print("Error updating profile followers: \(error.localizedDescription)")
                        } else {
                            // Reloading follower count after updating profile followers
                            self.loadFollowerFollowingCounts()
                            // Updating the button title based on new follow status
                            self.updateFollowButtonTitle()

                            // Updating logged-in user's following array
                            self.updateLoggedInUserFollowing()
                        }
                    }
                } else {
                    print("Error getting profile user document: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        
       }
    
    
    func updateLoggedInUserFollowing() {
        guard let loggedInUserID = loggedInUserID else {
            print("User not authenticated.")
            return
        }

        let loggedInUserDocRef = db.collection("Users").document(loggedInUserID)

        loggedInUserDocRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var loggedInUserFollowing = document.data()?["following"] as? [String] ?? []

                if self.isFollowing {
                    // If following, adding profile user's UUID to logged-in user's following array
                    loggedInUserFollowing.append(self.profileUserID!)
                } else {
                    // If unfollowing, removing profile user's UUID from logged-in user's following array
                    loggedInUserFollowing.removeAll { $0 == self.profileUserID }
                }

                // Updating logged-in user's following field in Firestore
                loggedInUserDocRef.updateData(["following": loggedInUserFollowing]) { error in
                    if let error = error {
                        print("Error updating logged-in user's following: \(error.localizedDescription)")
                    } else {
                        // Toggling the button title based on the updated follow status
                        self.updateFollowButtonTitle()
                    }
                }
            } else {
                print("Error getting logged-in user document: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

    func updateFollowButtonTitle() {
        let title = isFollowing ? "Following" : "Follow"
        followButton.setTitle(title, for: UIControl.State.normal)
    }
    
    
    
    @IBAction func messageButton(_ sender: UIButton) {
    }
    
    
    func loadUserData() {
        print("loadUserData called----")
        
        // Used whereField to get data using UUID
        db.collection("Users").whereField("UUID", isEqualTo: profileUserID).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting user document: \(error.localizedDescription)")
                return
            }
            
            if let document = querySnapshot?.documents.first {
                let name = document.data()["name"] as? String ?? ""
                let email = document.data()["email"] as? String ?? ""
                
                self.nameLabel.text = name
                self.emailLabel.text = email
                
                print("\(name) + \(email)")
            }
        }
    }
    
    //    ----------------------------------
    
    func loadFollowerFollowingCounts() {
        print("loadFollowerFollowingCounts called----")
        
        guard let profileUserID = profileUserID else {
            print("Profile user ID not available.")
            return
        }
        
        let userDocRef = db.collection("Users").document(profileUserID)
        
        userDocRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let followersCount = document.data()?["followers"] as? [String] ?? []
                let followingCount = document.data()?["following"] as? [String] ?? []
                
                self.followersCount.text = "\(followersCount.count)"
                self.followingCount.text = "\(followingCount.count)"
            } else {
                print("Error getting user document: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}

extension HomeViewController {
    func checkAndSetFollowStatus() {
            guard let loggedInUserID = loggedInUserID, let profileUserID = profileUserID else {
                print("User not authenticated.")
                return
            }
            let userDocRef = db.collection("Users").document(profileUserID)

            userDocRef.getDocument { [weak self] (document, error) in
                guard let self = self else { return }

                if let document = document, document.exists {
                    let profileFollowers = document.data()?["followers"] as? [String] ?? []
                    self.isFollowing = profileFollowers.contains(loggedInUserID)

                    // Seting the button title based on follow status
                    self.updateFollowButtonTitle()
                } else {
                    print("Error getting profile user document: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
    }
}

