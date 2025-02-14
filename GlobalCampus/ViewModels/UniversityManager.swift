import Foundation

class UniversityManager: ObservableObject {
    let api = Api()
    
    @Published var universities: [ApiUniversity] = []
    @Published var userInput: String = ""
    
    let BASE_URL = "http://universities.hipolabs.com"
    
    init() {
        Task {
            do {
                
            } catch {
                
            }
        }
    }
    
    func getTopUniversities() async throws {
        let retrievedUniversities: UniversityResponse = try await api.get(url: "\(BASE_URL)/search?name=technical")
        
        DispatchQueue.main.async {
            self.universities = retrievedUniversities.description
        }
    }
    
    func searchUniversities() async throws {
        guard !userInput.isEmpty else {
            
            DispatchQueue.main.async {
                self.universities = []
            }
            return
        }
        
        print("User input: \(userInput)")
        let retrievedUniversities: UniversityResponse = try await api.get(url: "\(BASE_URL)/search?name=\(userInput)")
        
        DispatchQueue.main.async {
            self.universities = retrievedUniversities.description
        }
    }
}
