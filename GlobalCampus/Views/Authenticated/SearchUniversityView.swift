import SwiftUI

struct SearchUniversityView: View {
    @EnvironmentObject var db: DbConnection
    @EnvironmentObject var universityManager: UniversityManager
    
    var body: some View {
        ZStack {
            Color("ButtonColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Picker("Search by", selection: $universityManager.searchType) {
                    Text("University Name").tag(SearchType.name)
                    Text("Country").tag(SearchType.country)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .background(Color("PrimaryColor"))
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .safeAreaInset(edge: .top) { Spacer().frame(height: 10) }
                
                TextField("Search \(universityManager.searchType == .name ? "Universities" : "Countries")", text: $universityManager.userInput)
                    .padding()
                    .background(Color("PrimaryColor"))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(universityManager.universities, id: \.id) { university in
                            UniversityCard(university: university)
                                .padding(.horizontal, 20)
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
        }
        .onChange(of: universityManager.userInput) {
            Task {
                do {
                    try await universityManager.searchUniversities()
                } catch {
                    print("Error fetching universities: \(error)")
                }
            }
        }
    }
}

#Preview {
    SearchUniversityView()
        .environmentObject(DbConnection())
        .environmentObject(UniversityManager())
}
