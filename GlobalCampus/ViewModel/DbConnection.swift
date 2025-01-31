//
//  DbConnection.swift
//  GlobalCampus
//
//  Created by Onur Kayhan on 2025-01-29.
//

import Foundation
import FirebaseFirestore

class DbConnection: ObservableObject {
    var db = Firestore.firestore()
    
    let COLLECTION_UNIVERSITIES = "universities"
    
    @Published var universities: [ApiUniversity] = []
    
    func startListeningToDb() {
    
        db.collection(COLLECTION_UNIVERSITIES).addSnapshotListener { snapshot, error in
        
            if let error = error {
                print("Error on snapshot: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            self.universities = []
            
            for document in snapshot.documents {
                document.data()
            }
            
        }
        
        
        
    }
    
    
}
