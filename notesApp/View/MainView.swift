import SwiftUI

struct MainView: View{
    @StateObject var viewModel = MainViewViewModel()
    var body: some View{
        if viewModel.isSignIn, !viewModel.currentUserId.isEmpty {
            accountView
        } else {
            LoginView()
        }
    }
    
    @ViewBuilder
    var accountView: some View {
        TabView{
            HomeView(userId: viewModel.currentUserId).tabItem {
                Label("Home", systemImage: "house")
            }
            ProfileView().tabItem {
                Label("Profile", systemImage: "person.circle")
            }
        }.accentColor(Color.AppPrimary.vibrantPurple)
    }
}

#Preview {
    MainView()
}


