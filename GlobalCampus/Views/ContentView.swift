import SwiftUI

struct ContentView: View {
    @EnvironmentObject var db: DbConnection
    @State private var selectedTab = 0
    
    init() {
        // Set the unselected tab color globally
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "PrimaryColor")
    }

    var body: some View {
        if db.currentUser != nil {
            TabView(selection: $selectedTab) {
                NavigationStack {
                    HomeView()
                }
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)

                NavigationStack {
                    AboutCompanyView()
                }
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
                .tag(1)
            }
            .tint(Color("SecondaryColor")) // Selected tab color
        } else {
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
// TODO: CHANGE ENROLLED BUTTON TO SOMETHING MORE DISABLED GRAYISH
