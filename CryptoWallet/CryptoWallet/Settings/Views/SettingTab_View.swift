import SwiftUI

struct SettingTab_View: View {
    
    @State private var scrollViewContentOffset = CGFloat(0)
    @Binding var scrollPosition: CGFloat
    @State var toogleSwitchHomeTab: Bool = true
    @State var colorThemeRestartWarning: Bool = false
    
    let fontArray: [String] = ["default","rounded","monospaced","serif"]
    let colorThemeArray: [String] = ["button","buttonGreen","buttonPurple","buttonRed","buttonYellow"]
    
    // MARK: Color Theme User Default
    @AppStorage("colorTheme") var colorTheme: String = "button"
    
    // MARK: Font Style User Default
    @AppStorage("fontStyle") var fontStyle: String = "default"
    
    // MARK: Home Tab User Default
    @AppStorage("showFilterOptionHomeTab") var showFilterOptionHomeTab: Bool = true
    @AppStorage("showMarketStatsHomeTab") var showMarketStatsHomeTab: Bool = true
    @AppStorage("showPercenntageChangeHomeTab") var showPercenntageChangeHomeTab: Bool = true
    
    // MARK: Portfolio Tab User Default
    @AppStorage("showFilterOptionPortfolioTab") var showFilterOptionPortfolioTab: Bool = true
    @AppStorage("showMarketStatsPortfolioTab") var showMarketStatsPortfolioTab: Bool = true
    
    // MARK: News Tab User Default
    @AppStorage("showAuthorNameNewsTab") var showAuthorNameNewsTab: Bool = true
    @AppStorage("newsGenresSelection") var newsGenresSelection: String = "Crypto"
    
    // MARK: Gereral User Defaults
    @AppStorage("progressViewStyle") var progressViewStyle: String = "MacOS"
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            scrollTracker_NavBar
        }
        .background(Color.theme.background)
        
        .alert("Restart App", isPresented: $colorThemeRestartWarning) {
            Button("Ok") {
                exit(0)
            }
        } message: {
            Text("You need to restart your app to apply theme")
        }
    }
}

extension SettingTab_View {
    private var scrollTracker_NavBar: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .center, spacing: 0) {
                CustomNavBar_View(title: "Settings").opacity(0.0) // For White Space
                
                TrackableScrollView(.vertical, showIndicators: false, contentOffset: $scrollViewContentOffset, content: {
                    
                    // MARK: All Settings Rows
                    LazyVStack(spacing: 9) {
                        settingList
                    }
                    
                })
                .onChange(of: scrollViewContentOffset, perform: { value in
                    withAnimation(.spring()) {
                        scrollPosition = scrollViewContentOffset
                    }
                })
                .onAppear {
                    scrollPosition = 0
                }
                
            }
            
            // MARK: Navigation Title
            CustomNavBar_View(title: "Settings")
                .background(
                    scrollPosition < 25 ? Color.black.opacity(0.0) : Color.theme.secondaryBackground
                )
        }
        .background(Color.theme.background)
    }
    
    // MARK: All Settings Section
    private var settingList: some View {
        VStack(spacing: 11) {
            
            // MARK: Color Theme Section
            SingleRow_Setting_View(title: "Color Theme", imageName: "paintbrush.fill") {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(colorThemeArray, id: \.self) { color in
                            Button {
                                withAnimation {
                                    colorTheme = color
                                    Color.theme.setTheme()
                                    colorThemeRestartWarning.toggle()
                                }
                            } label: {
                                Circle()
                                    .frame(width: 35)
                                    .foregroundColor(Color(color))
                                    .opacity(0.8)
                                    .overlay {
                                        if colorTheme == color {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(Color.theme.secondaryBackground)
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            
            // MARK: Font Style Section
            SingleRow_Setting_View(title: "Font Style", imageName: "textformat.alt") {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(fontArray, id: \.self) { fontImage in
                            Button {
                                withAnimation {
                                    fontStyle = fontImage
                                }
                            } label: {
                                Image(fontImage)
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFill()
                                    .foregroundColor(fontStyle == fontImage ? Color.theme.background : .gray)
                                    .opacity(0.8)
                                    .frame(height: 16)
                                    .padding(8)
                                    .padding(.horizontal, 10)
                                    .background(fontStyle == fontImage ? Color.theme.button : Color.theme.button.opacity(0.1))
                                    .cornerRadius(20)
                            }
                        }
                    }
                }
            }
            
            // MARK: HomeTab Section
            SingleRow_Setting_View(title: "Home Tab", imageName: "house.fill") {
                // MARK: 1
                HStack {
                    Text("Filter Option")
                        .fontWeight(.medium)
                        .foregroundColor(Color.theme.secondaryTitle)
                    Spacer()
                    Toggle("", isOn: $showFilterOptionHomeTab)
                        .tint(Color.theme.button)
                }
                Divider()
                // MARK: 2
                HStack {
                    Text("Market Stats")
                        .fontWeight(.medium)
                        .foregroundColor(Color.theme.secondaryTitle)
                    Spacer()
                    Toggle("", isOn: $showMarketStatsHomeTab)
                        .tint(Color.theme.button)
                }
                Divider()
                // MARK: 3
                HStack {
                    Text("Price Change %")
                        .fontWeight(.medium)
                        .foregroundColor(Color.theme.secondaryTitle)
                    Spacer()
                    Toggle("", isOn: $showPercenntageChangeHomeTab)
                        .tint(Color.theme.button)
                }
            }
            
            // MARK: Portfolio Tab Section
            SingleRow_Setting_View(title: "Portfolio Tab", imageName: "person.fill") {
                // MARK: 1
                HStack {
                    Text("Filter Option")
                        .fontWeight(.medium)
                        .foregroundColor(Color.theme.secondaryTitle)
                    Spacer()
                    Toggle("", isOn: $showFilterOptionPortfolioTab)
                        .tint(Color.theme.button)
                }
                Divider()
                // MARK: 2
                HStack {
                    Text("Market Stats")
                        .fontWeight(.medium)
                        .foregroundColor(Color.theme.secondaryTitle)
                    Spacer()
                    Toggle("", isOn: $showMarketStatsPortfolioTab)
                        .tint(Color.theme.button)
                }
            }
            
            // MARK: News Tab Section
            SingleRow_Setting_View(title: "News Tab", imageName: "newspaper.fill") {
                // MARK: 1
                HStack {
                    Text("Author Name")
                        .fontWeight(.medium)
                        .foregroundColor(Color.theme.secondaryTitle)
                    Spacer()
                    Toggle("", isOn: $showAuthorNameNewsTab)
                        .tint(Color.theme.button)
                }
                Divider()
                // MARK: 2
                HStack {
                    Text("News Genres")
                        .fontWeight(.medium)
                        .foregroundColor(Color.theme.secondaryTitle)
                    Spacer()
                    
                    Picker("", selection: $newsGenresSelection) {
                        Text("Crypto")
                            .tag("Crypto")
                        Text("Sports")
                            .tag("Sports")
                        Text("Entertainment")
                            .tag("Entertainment")
                        Text("Technology")
                            .tag("Technology")
                    }
                    .tint(Color.theme.button)
                    .pickerStyle(.menu)
                }
            }
            
            // MARK: General Section
            SingleRow_Setting_View(title: "Gerneral Settings", imageName: "gearshape.fill") {
                HStack(alignment: .top) {
                    Text("ProgressView Style")
                        .fontWeight(.medium)
                        .foregroundColor(Color.theme.secondaryTitle)
                    Spacer()
                    
                    Picker("", selection: $progressViewStyle) {
                        Text("MacOS")
                            .tag("MacOS")
                        Text("Default")
                            .tag("Default")
                    }
                    .pickerStyle(.menu)
                    .tint(Color.theme.button)
                }
            }
        }
    }
}
