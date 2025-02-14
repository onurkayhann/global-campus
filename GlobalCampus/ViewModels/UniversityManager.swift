import Foundation

class UniversityManager: ObservableObject {
    let api = Api()
    
    @Published var universities: [ApiUniversity] = []
    @Published var topRankedUniversities: [ApiUniversity] = []
    
    @Published var userInput: String = ""
    @Published var searchType: SearchType = .name
    
    let BASE_URL = "http://universities.hipolabs.com"
    
    init() {
        Task {
            do {
                try await getTopUniversities()
            } catch {
                print("Error loading universities: \(error.localizedDescription)")
            }
        }
    }
    
    func getTopUniversities() async throws {
        let retrievedUniversities: UniversityResponse = try await api.get(url: "\(BASE_URL)/search?name=technical")
        
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
            
            let searchQuery = userInput.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            let endpoint = searchType == .name
                ? "\(BASE_URL)/search?name=\(searchQuery)" // ✅ Search by name
                : "\(BASE_URL)/search?country=\(searchQuery)" // ✅ Search by country
            
            print("🔍 Searching \(searchType == .name ? "Universities" : "Countries") for: \(userInput)")

            do {
                let retrievedUniversities: UniversityResponse = try await api.get(url: endpoint)

                DispatchQueue.main.async {
                    self.universities = retrievedUniversities
                }
            } catch {
                print("❌ Error fetching universities: \(error.localizedDescription)")
            }
        }
    
    func searchUniversitiesByCountry() async throws {
        guard !userInput.isEmpty else {
            
            DispatchQueue.main.async {
                self.universities = []
            }
            return
        }
        
        print("User input: \(userInput)")
        let retrievedUniversities: UniversityResponse = try await api.get(url: "\(BASE_URL)/search?country=\(userInput)")
        
        DispatchQueue.main.async {
            self.universities = retrievedUniversities
        }
    }
}

enum SearchType {
    case name
    case country
}
