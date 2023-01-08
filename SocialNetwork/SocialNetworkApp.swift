
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

    @EnvironmentObject var loginVM: LoginViewModel
    @EnvironmentObject var postVM: PostViewModel
    @State var session : Session?
    @State var post : Post? = Post()

    var body: some View {
        if (loginVM.isLoggedIn) {
            Home(session: $session, post: $post)
        } else {
            Home(session: $session, post: $post)
        }

    }
}
