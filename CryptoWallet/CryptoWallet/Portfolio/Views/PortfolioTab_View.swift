import SwiftUI

struct PortfolioTab_View: View {
    
    @EnvironmentObject private var homeTab_ViewModel: HomeTab_ViewModel
    @StateObject var viewModel = PortfolioTab_ViewModel()
    
    // MARK: User Defaults
    @AppStorage("showFilterOptionPortfolioTab") var showFilterOptionPortfolioTab: Bool = true
    @AppStorage("showMarketStatsPortfolioTab") var showMarketStatsPortfolioTab: Bool = true
    
    @State private var scrollViewContentOffset = CGFloat(0)
    @Binding var scrollPosition: CGFloat
    @State var textFieldString: String = ""
    @State var showKeyboardDismiss: Bool = false
    @State var toogleSheet: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            scrollTracker_NavBar
            
            // MARK: Add Button
            addButton
        }
        .background(Color.theme.background)
        
        .sheet(isPresented: $toogleSheet) {
            AddToPortfolio_View()
        }
    }
}

extension PortfolioTab_View {
    
    // MARK: ScrollTracker And Navbar
    private var scrollTracker_NavBar: some View {
        ZStack(alignment: .top) {
            mainContent_TrackableScroll
            
            // MARK: Navbar Title
            CustomNavBar_View(title: "Portfolio")
                .background(
                    scrollPosition < 25 ? Color.black.opacity(0.0) : Color.theme.secondaryBackground
                )
        }
        .background(Color.theme.background)
    }
    
    private var mainContent_TrackableScroll: some View {
        VStack(alignment: .center, spacing: 0) {
            CustomNavBar_View(title: "Live Prices").opacity(0.0) // For White Space
            
            TrackableScrollView(.vertical, showIndicators: false, contentOffset: $scrollViewContentOffset, content: {
                
                // MARK: Search Bar
                SearchBar_View(searchFilterString: $textFieldString, showKeyboardDismiss: $showKeyboardDismiss)
                
                // MARK: From User Defaults
                if showMarketStatsPortfolioTab {
                    // MARK: Market Stats
                    topMarketStats
                }
                
                // MARK: Coin Tuples
                LazyVStack(spacing: 9) {
                    if showFilterOptionPortfolioTab {
                        // MARK: Filter Menu's
                        horizontalSortButtons
                    }
                    
                    ForEach(homeTab_ViewModel.userPortfolioCoins) { coin in
                        SingleCoinRowPortfolio_View(coin: coin)
                    }
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
    }
    
    // MARK: Filter Menu's View
    private var horizontalSortButtons: some View {
        HStack {
            Button {
                withAnimation { homeTab_ViewModel.mainCoinPriceSortButton() }
            } label: {
                SortingButton_View(buttonTitle: "Price", sortType: homeTab_ViewModel.trackSortPrice)
            }
            Spacer()
            Button {
                withAnimation { homeTab_ViewModel.sortuserHolding() }
            } label: {
                SortingButton_View(buttonTitle: "Holdings", sortType: homeTab_ViewModel.trackSort_userPortfolioHolding)
            }
        }
        .foregroundColor(Color.theme.button)
        .font(.system(.callout, design: .rounded, weight: .medium))
        .padding(.horizontal, DefaultValues.shared.gloabalPaddingValue + 10)
        .padding(.vertical, 4)
    }
    
    // MARK: Add Coin to Portfolio View
    private var addButton: some View {
        VStack {
            Button {
                toogleSheet.toggle()
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Add")
                        .font(.headline)
                }
                .fontWeight(.medium)
                .foregroundColor(Color.theme.secondaryBackground)
                .padding(10)
                .padding(.horizontal, 7)
                .background(Color.theme.button)
                .cornerRadius(100)
                .padding(DefaultValues.shared.gloabalPaddingValue)
            }
        }
    }
    
    // MARK: Top Market Stats Components
    private var topMarketStats: some View {
        HStack(spacing: 0) {
            ForEach(viewModel.marketStatsForPortfolio) { stats in
                MarketPlaceStatistics_View(marketPlaceStatistics: stats)
                    .padding(.horizontal, 5)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, DefaultValues.shared.gloabalPaddingValue - 5)
        .padding(.vertical, 5)
    }
}
