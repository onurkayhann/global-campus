import SwiftUI

struct ContentView: View {
    @EnvironmentObject var db: DbConnection
    @State private var selectedTab = 0

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

                NavigationStack {
                    SearchUniversityView()
                }
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(2)
                
                NavigationStack {
                    ApplicationView()
                }
                .tabItem {
                    Label("Application", systemImage: "graduationcap.fill")
                }
                .tag(3)

                NavigationStack {
                    ProfileView()
                }
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
                .tag(4)
            }
            .onAppear {
                UITabBar.appearance().unselectedItemTintColor = UIColor(named: "PrimaryColor")
            }
            .tint(Color("ThirdColor"))
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


// TODO: CHANGE ENROLLED BUTTON TO SOMETHING MORE DISABLED GRAYISH
// TODO: BACK THING HAS TO BE RESOLVED
