import SwiftUI

@main
struct CryptoWalletApp: App {
    
    @StateObject var homeTab_ViewModel = HomeTab_ViewModel()
    
    @AppStorage("fontStyle") var fontStyle: String = "default"
    @AppStorage("showBoarding") var showBoarding: Bool = true
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeTab_View()
                    .modifier(FontModifier(fontStyle: fontStyle))
                    .navigationBarHidden(true)
                
                    .sheet(
                        isPresented: $showBoarding,
                        onDismiss: {
                            showBoarding = false
                        }) {
                            Boarding_View()
                        }
            }
            .environmentObject(homeTab_ViewModel)
        }
    }
}
