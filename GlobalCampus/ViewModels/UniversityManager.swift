import Foundation

class UniversityManager: ObservableObject {
    let api = Api()
    
    @Published var universities: [ApiUniversity] = []
    @Published var topRankedUniversities: [ApiUniversity] = []
    
    @Published var userInput: String = ""
    
    let BASE_URL = "http://universities.hipolabs.com"
    
    init() {
        Task {
            do {
                try await getTopUniversities()
            } catch {
                print("Error loading univerrsities: \(error.localizedDescription)")
            }
        }
    }
    
    func getTopUniversities() async throws {
        let retrievedUniversities: UniversityResponse = try await api.get(url: "\(BASE_URL)/search?country=turkey")
        
        DispatchQueue.main.async {
            self.topRankedUniversities = retrievedUniversities
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
            self.universities = retrievedUniversities
        }
    }
}
