import SwiftUI

struct HomeView: View {
    @EnvironmentObject var db: DbConnection
    @EnvironmentObject var universityManager: UniversityManager
    
    var body: some View {
        ZStack {
            Color("ButtonColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack(spacing: 0) {
                    Text("Welcome ").font(.title).foregroundStyle(Color("SecondaryColor"))
                    Text(db.currentUserData?.name ?? "No user found")
                        .foregroundStyle(Color("PrimaryColor"))
                        .font(.title)
                        .bold()
                }
                .padding(.top, 30)

                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(universityManager.topRankedUniversities) { university in
                            UniversityCard(university: university)
                                .padding(.horizontal, 20)
                        }
                    }
                    .padding(.vertical, 10)
                }
                
                Button("Logout") {
                    db.signOut()
                }
                .bold()
                .padding()
                .padding(.horizontal, 25)
                .padding(.vertical, 5)
                .foregroundStyle(Color("SecondaryColor"))
                .background(Color("LogoutColor"))
                .clipShape(Capsule())
                .padding(.bottom, 20)
            }
        }
        .onAppear {
            Task {
                do {
                    try await universityManager.getTopUniversities()
                    //try await universityManager.getUpcomingMovies()
                } catch {
                    print("Error fetching universities: \(error)")
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(DbConnection())
        .environmentObject(UniversityManager())
}
