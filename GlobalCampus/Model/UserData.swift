//
//  UserData.swift
//  GlobalCampus
//
//  Created by Onur Kayhan on 2025-01-31.
//

import Foundation

struct UserData: Codable {
    var name: String
    var universityApplication: [UniversityApplication]
}

struct UniversityApplication: Codable, Identifiable {
    
    var id: UUID? = UUID()
    var name: String
    var country: String
    var alphaTwoCode: String
    var domains: [String]
    var webPages: [String]
    
    func toDictionary() -> [String: Any] {
        return [
            "id": (id ?? UUID()).uuidString,
            "name": name,
            "country": country,
            "alphaTwoCode": alphaTwoCode,
            "domains": domains,
            "webPages": webPages
        ]
    }
}

extension UniversityApplication {
    func toApiUniversity() -> ApiUniversity {
        return ApiUniversity(id: id, name: name, country: country, alphaTwoCode: alphaTwoCode, domains: domains, webPages: webPages)
    }
}
