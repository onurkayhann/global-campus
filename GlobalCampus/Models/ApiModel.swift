import Foundation
import FirebaseFirestore

struct ApiUniversity: Codable, Identifiable {
    
    @DocumentID var id: String?
    var name: String
    var country: String
}

/*
extension ApiUniversity {
    func toUniversityApplication() -> UniversityApplication {
        return UniversityApplication(id: id, name: name, country: country)
    }
}
*/
