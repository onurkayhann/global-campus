//
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var db: DbConnection
    
    var body: some View {
        
        VStack {
            Text("Universities!").font(.title2)
                ForEach(db.universities) { university in
                    UniversityCard(university: university)
            }
            
            Button("Logout") {
                db.signOut()
            }
            .bold()
            .padding()
            .padding(.horizontal, 25)
            .padding(.vertical, 5)
            .foregroundStyle(.white)
            .background(.red)
            .clipShape(Capsule())
            .padding()
            
        }.padding()
    }
}

#Preview {
    HomeView().environmentObject(DbConnection())
}
