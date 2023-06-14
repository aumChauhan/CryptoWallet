import SwiftUI

struct InitialTabView: View {
    
    @State var tabSelection: TabModel = TabModel(iconName: "house.fill", title: "Home")
    @EnvironmentObject private var homeTab_ViewModel: HomeTab_ViewModel

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack{
                switch tabSelection {
                case TabModel(iconName: "house.fill", title: "Home"):
                    HomeTab_View()
                    
                case TabModel(iconName: "person.fill", title: "Portfolio"):
                    VStack { PortfolioTab_View() }
                    
                case TabModel(iconName: "newspaper.fill", title: "News"):
                    NewsTab_View()
                    
                case TabModel(iconName: "gear", title: "Setting"):
                    SettingTab_View()
                    
                default:
                    HomeTab_View()
                }
                Spacer()
                CustomTabBar_View(tabSelection: $tabSelection)
            }
        }
        .background(Color.theme.background)
    }
}

struct InitialTabView_Previews: PreviewProvider {
    static var previews: some View {
        InitialTabView()
            .environmentObject(debugPreview.homeViewModel)

    }
}
