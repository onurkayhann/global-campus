import Foundation
import FirebaseFirestore
import FirebaseAuth

class DbConnection: ObservableObject {
    
    var db = Firestore.firestore()
    
    let COLLECTION_UNIVERSITIES = "universities"
    @Published var universities: [ApiUniversity] = []
    var universityListener: ListenerRegistration?
    
    var auth = Auth.auth()
    let COLLECTION_USER_DATA = "user_data"
    @Published var currentUser: User?
    @Published var currentUserData: UserData?
    var userDataListener: ListenerRegistration?
    
    init() {
        let _ = auth.addStateDidChangeListener { auth, user in
            
            if let user = user {
                // Användaren har loggat in
                self.currentUser = user
                self.startUniversityListener()
                self.startUserDataListener()
                
            } else {
                // Användaren har loggat ut
                self.currentUser = nil
                self.universityListener?.remove()
                self.universityListener = nil
                
                self.userDataListener?.remove()
                self.userDataListener = nil
                self.currentUserData = nil
            }
        }
    }
    
    /// REGISTER
    
    func registerUser(name: String, email: String, password: String, confirmPassword: String) {
        
        guard password == confirmPassword else {
            print("Error: Passwords do not match!")
            return
        }
        
        auth.createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let authResult = authResult else { return }
            
            let newUserData = UserData(name: name, universityApplication: [])
            
            do {
                try self.db.collection(self.COLLECTION_USER_DATA).document(authResult.user.uid).setData(from: newUserData)
            } catch let error {
                print("Failed to create userData: \(error.localizedDescription)")
            }
        }
    }
    
    /// LOGIN
    
    func loginUser(email: String, password: String) {
        auth.signIn(withEmail: email, password: password)
    }
    
    /// LOGOUT
    
    func signOut() {
        do {
            try auth.signOut()
            currentUser = nil
            currentUserData = nil
        } catch _ {
            
        }
    }
    
    /// ADD UNIVERSITY TO USER APPLICATION
    
    func addUniversityToApplication(universityName: String) {
        guard let currentUser = currentUser else { return }

        DispatchQueue.main.async {
            if self.currentUserData?.universityApplication.contains(universityName) == false {
                self.currentUserData?.universityApplication.append(universityName)
            }
        }

        db.collection(COLLECTION_USER_DATA)
            .document(currentUser.uid)
            .updateData(["universityApplication": FieldValue.arrayUnion([universityName])]) { error in
                if let error = error {
                    print("❌ Error adding university: \(error.localizedDescription)")

                    DispatchQueue.main.async {
                        self.currentUserData?.universityApplication.removeAll { $0 == universityName }
                    }
                } else {
                    print("✅ University added successfully: \(universityName)")
                }
            }
    }

    func deleteUniversityFromApplication(universityName: String) {
        guard let currentUser = currentUser else { return }

        DispatchQueue.main.async {
            self.currentUserData?.universityApplication.removeAll { $0 == universityName }
        }

        db.collection(COLLECTION_USER_DATA)
            .document(currentUser.uid)
            .updateData(["universityApplication": FieldValue.arrayRemove([universityName])]) { error in
                if let error = error {
                    print("❌ Error removing university: \(error.localizedDescription)")

                    DispatchQueue.main.async {
                        self.currentUserData?.universityApplication.append(universityName)
                    }
                } else {
                    print("✅ University removed successfully: \(universityName)")
                }
            }
    }

    
    /// LISTENERS
    
    func startUniversityListener() {
        universityListener = db.collection(COLLECTION_UNIVERSITIES).addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error on snapshot: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            DispatchQueue.main.async {
                self.universities = snapshot.documents.compactMap { document in
                    do {
                        let university = try document.data(as: ApiUniversity.self)
                        print("Fetched university: \(university.name), Country: \(university.country)")
                        return university
                    } catch let error {
                        print("Error decoding university: \(error.localizedDescription)")
                        return nil
                    }
                }
                print("Total universities fetched: \(self.universities.count)")
            }
        }
    }

    
    func startUserDataListener() {
        guard let currentUser = currentUser else { return }
        
        userDataListener = db.collection(COLLECTION_USER_DATA).document(currentUser.uid).addSnapshotListener { snapshot, error in
            
            if let error = error {
                print("Error listening to user data! \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            do {
                self.currentUserData = try snapshot.data(as: UserData.self)
            } catch _ {
                print("Could not convert the user's data")
            }
        }
    }
}
