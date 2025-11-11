import SwiftUI

@main
struct TechNewsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                NewsView()
            }
        }
    }
}
