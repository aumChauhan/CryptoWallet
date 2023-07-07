import SwiftUI

struct HomeTab_View: View {
    
    @EnvironmentObject private var homeTab_ViewModel: HomeTab_ViewModel
    
    @State var tabSelection: TabModel = TabModel(iconName: "house.fill", title: "Home")
    @State private var scrollViewContentOffset = CGFloat(0)
    @State private var scrollPosition: CGFloat = 0
    @State var showKeyboardDismiss: Bool = false
    @State var tabSelectionTag: String = "home"
    
    // MARK: User Defaults
    @AppStorage("showFilterOptionHomeTab") var showFilterOptionHomeTab: Bool = true
    @AppStorage("showMarketStatsHomeTab") var showMarketStatsHomeTab: Bool = true
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            switch_tabSelection
            CustomTabBar_View(tabSelection: $tabSelection)
        }
        .ignoresSafeArea(.keyboard)
        .navigationDestination(for: Coin_DataModel.self) { coin in
            DetailedCoin_View(coin: coin)
        }
    }
}

extension HomeTab_View {
    // MARK: Tab Selector
    private var switch_tabSelection: some View {
        ZStack {
            TabView(selection: $tabSelection) {
                homeTab_HeaderAndContent
                    .tag(TabModel(iconName: "house.fill", title: "Home"))
                
                PortfolioTab_View()
                    .tag(TabModel(iconName: "person.fill", title: "Portfolio"))
                
                NewsTab_View()
                    .tag(TabModel(iconName: "newspaper.fill", title: "News"))
                
                SettingTab_View()
                    .tag(TabModel(iconName: "gear", title: "Setting"))
            }
            .tint(Color.theme.button)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // MARK: Navigation Title
    private var homeTab_HeaderAndContent: some View {
        ZStack(alignment: .top) {
            allComponentsAndCryptoCurrencyRows
            
            CustomNavBar_View(title: "Live Prices")
                .background(
                    scrollPosition < 25 ? Color.theme.background : Color.theme.secondaryBackground
                )
        }
        .background(Color.theme.background)
    }
    
    // MARK: TrackableScroll View
    private var allComponentsAndCryptoCurrencyRows: some View {
        VStack(alignment: .center, spacing: 0) {
            TrackableScrollView(.vertical, showIndicators: false, contentOffset: $scrollViewContentOffset, content: {
                
                CustomNavBar_View(title: "Live Prices").opacity(0.0) // White Space
                
                // MARK: Search Bar View
                SearchBar_View(searchFilterString:  $homeTab_ViewModel.searchFilterString, showKeyboardDismiss: $showKeyboardDismiss)
                
                // MARK: From User Defaults
                if showMarketStatsHomeTab {
                    topMarketStats
                }
                
                // MARK: Coins Tuples
                LazyVStack(spacing:9) {
                    // MARK: From User Defaults
                    if showFilterOptionHomeTab {
                        horizontalSortButtons
                    }
                    
                    ForEach(homeTab_ViewModel.allCoins) { coin in
                        NavigationLink(value: coin) {
                            SingleCoinRow_View(coin: coin)
                        }
                    }
                }
            })
            .onChange(of: scrollViewContentOffset, perform: { value in
                withAnimation(.spring()) {
                    scrollPosition = scrollViewContentOffset
                }
            })
            .refreshable {
                homeTab_ViewModel.reloadData()
            }
            
        }
    }
    
    // MARK: Sorting Buttons
    private var horizontalSortButtons: some View {
        HStack(spacing: 0) {
            Button {
                withAnimation {  homeTab_ViewModel.mainCoinPriceSortButton() }
            } label: {
                SortingButton_View(buttonTitle: "Price", sortType: homeTab_ViewModel.trackSortPrice)
            }
            Spacer()
            Button {
                withAnimation { homeTab_ViewModel.sortPercentageChange24h() }
            } label: {
                SortingButton_View(buttonTitle: "Price Change %", sortType: homeTab_ViewModel.trackSortPrice_Percentage24h)
            }
            
        }
        .foregroundColor(Color.theme.button)
        .font(.system(.callout, design: .rounded, weight: .medium))
        .padding(.horizontal, DefaultValues.shared.gloabalPaddingValue + 13)
        .padding(.vertical, 5)
    }
    
    // MARK: Top Market Stats Components
    private var topMarketStats: some View {
        HStack(spacing: 0) {
            ForEach(homeTab_ViewModel.marketStats) { stats in
                MarketPlaceStatistics_View(marketPlaceStatistics: stats)
                    .padding(.horizontal, 4)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, DefaultValues.shared.gloabalPaddingValue - 4)
        .padding(.vertical, 5)
    }
    
}

struct HomeTab_View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeTab_View()
                .navigationBarHidden(true)
        }
        .environmentObject(debugPreview.homeViewModel)
    }
}
