//
//  DbConnection.swift
//  GlobalCampus
//
//  Created by Onur Kayhan on 2025-01-29.
//

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
        
        auth.addStateDidChangeListener { auth, user in
            
            if let user = user {
                // Användaren har loggat in
                self.currentUser = user
                self.startUniversityListener()
                
            } else {
                // Användaren har loggat ut
                self.currentUser = nil
                self.universityListener?.remove()
                self.universityListener = nil
                
                self.userDataListener?.remove()
                self.userDataListener = nil
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
    
    /// REMOVE UNIVERSITY FROM USER APPLICATION
    
    func deleteUniversityFromApplication(id: UUID) {
        let universityToDelete = universities.first { $0.id == id }
        
        guard let universityToDelete = universityToDelete else { return }
        guard let universityId = universityToDelete.id else { return }
        
        db.collection(COLLECTION_USER_DATA).document(universityId.uuidString).delete { error in
            if let error = error {
                print("Error deleting university: \(error.localizedDescription)")
            } else {
                print("University successfully deleted.")
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
            
            self.universities = []
            
            for document in snapshot.documents {
                
                do {
                    let university = try document.data(as: ApiUniversity.self)
                } catch let error {
                    print("Something went wrong: \(error.localizedDescription)")
                }
            }
            
        }
    }
    
    func startUserDataListener() {
        userDataListener = db.collection(COLLECTION_USER_DATA).addSnapshotListener { snapshot, error in
            
            if let error = error {
                print("Error on snapshot: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            guard let currentUser = self.currentUser else { return }
            
            let foundUserDataDoc = snapshot.documents.first { $0.documentID == currentUser.uid }
            
            guard let foundUserDataDoc = foundUserDataDoc else {
                print("A UserData document was not found for the logged in user!")
                return
            }
            
            do {
                let foundUserData = try foundUserDataDoc.data(as: UserData.self)
                self.currentUserData = foundUserData
            } catch let error {
                print("Error transforming userData dictionary to UserData struct! \(error.localizedDescription)")
            }
            
            
        }
    }
    
}
