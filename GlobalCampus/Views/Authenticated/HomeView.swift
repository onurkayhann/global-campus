import SwiftUI

struct HomeView: View {
    @EnvironmentObject var db: DbConnection
    
    var body: some View {
        ZStack {
            Color("ButtonColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Universities!")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color("SecondaryColor"))
                    .padding(.top, 10)

                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(db.universities) { university in
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
    }
}

#Preview {
    HomeView().environmentObject(DbConnection())
}
