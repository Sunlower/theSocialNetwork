
import SwiftUI

@main
struct SocialNetworkApp: App {

    @StateObject var userStateViewModel = LoginViewModel()
    @StateObject var postStateViewModel = PostViewModel()


    var body: some Scene {
        WindowGroup {
            NavigationView{
                ApplicationSwitcher()
            }
            .navigationViewStyle(.stack)
            .environmentObject(userStateViewModel)
            .environmentObject(postStateViewModel)
        }
    }
}

struct ApplicationSwitcher: View {

    @EnvironmentObject var vm: LoginViewModel
    @State var session : Session?

    var body: some View {
        if (vm.isLoggedIn) {
            Home(session: $session)
        } else {
            Login( login: $session)
        }

    }
}
