import Foundation
import FirebaseFirestore

struct LoginRequest: Encodable {
    var email: String
    var password: String
}

struct RegisterRequest: Encodable {
    var name: String
    var email: String
    var pasword: String
}

struct AuthResponse: Decodable {
    var success: Bool
    var message: String
}

typealias UniversityResponse = [ApiUniversity]

struct ApiUniversity: Codable, Identifiable {
    var id: String? { UUID().uuidString }
    var name: String
    var country: String
}

extension ApiUniversity {
    func toSavedUniversity() -> SavedUniversity {
        return SavedUniversity(id: id, name: name, country: country)
    }
}

struct SavedUniversity: Codable {
    var id: String?
    var name: String
    var country: String
}
