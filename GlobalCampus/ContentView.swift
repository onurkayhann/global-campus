import SwiftUI

struct ContentView: View {
    @EnvironmentObject var db: DbConnection
    
    var body: some View {
        
        if db.currentUser != nil {
            // Logged in view
            NavigationStack {
                HomeView()
            }
        } else {
            // Not logged in view
            NavigationStack {
                LoginView()
            }
        }
        
    }
}

#Preview {
    ContentView().environmentObject(DbConnection())
}

// TODO: ADD TABVIEW HERE
