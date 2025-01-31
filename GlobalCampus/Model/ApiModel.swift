//
//  ApiUniversity.swift
//  GlobalCampus
//
//  Created by Onur Kayhan on 2025-01-29.
//

import Foundation

struct ApiUniversity: Codable, Identifiable {
    
    var id: UUID? = UUID()
    var name: String
    var country: String
    var alphaTwoCode: String
    var domains: [String]
    var webPages: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case country
        case alphaTwoCode = "alpha_two_code"
        case domains
        case webPages = "web_pages"
    }
}

extension ApiUniversity {
    func toUniversityApplication() -> UniversityApplication {
        return UniversityApplication(id: id, name: name, country: country, alphaTwoCode: alphaTwoCode, domains: domains, webPages: webPages)
    }
}
