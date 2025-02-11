import Foundation
import CoreLocation

struct Company: Identifiable, Codable {
    var id = UUID().uuidString
    var name: String
    var location: Location
}

struct Location: Codable {
    var latitude: Double
    var longitude: Double
}
