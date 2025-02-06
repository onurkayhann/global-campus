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
}

extension ApiUniversity {
    func toUniversityApplication() -> UniversityApplication {
        return UniversityApplication(id: id, name: name, country: country)
    }
}
