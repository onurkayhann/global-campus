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

struct UniversityResponse: Codable {
    var description: [ApiUniversity]
}

struct ApiUniversity: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String 
    var country: String
}
