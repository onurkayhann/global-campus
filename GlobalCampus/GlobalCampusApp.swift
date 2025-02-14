import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct GlobalCampusApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var dbConnection = DbConnection()
    @StateObject var universityManager = UniversityManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dbConnection)
                .environmentObject(universityManager)
        }
    }
}
