import SwiftUI

struct AddToPortfolio_View: View {
    
    @EnvironmentObject private var homeTab_ViewModel: HomeTab_ViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var scrollViewContentOffset = CGFloat(0)
    @State private var scrollPosition: CGFloat = 0
    @State var searchBarString: String = ""
    @State var showDismissKeyboard: Bool = false
    @State var selectedCoin: Coin_DataModel? = nil
    @State var userHoldings: String = ""
    
    var body: some View {
        VStack {
            swipeSheetDown
            
            trackableScroll_MainContent
        }
        .background(Color.theme.background)
    }
}

extension AddToPortfolio_View {
    
    private var trackableScroll_MainContent: some View {
        TrackableScrollView(.vertical, showIndicators: false, contentOffset: $scrollViewContentOffset) {
            
            // MARK: Serach Bar
            SearchBar_View(searchFilterString: $homeTab_ViewModel.searchFilterString, showKeyboardDismiss: $showDismissKeyboard)
            
            // MARK: All Coins
            horizontalAllCoins
            
            // MARK: Filter Menus
            horizontalSortButtons
            
            // MARK: TextFields
            statsAndTextField
            
            if selectedCoin != nil && !userHoldings.isEmpty  {
                // MARK: Add to wallet button
                addButton
            }
            
        }
        .onChange(of: scrollViewContentOffset, perform: { value in
            withAnimation(.spring()) {
                scrollPosition = scrollViewContentOffset
            }
        })
    }
    
    // MARK: All Coins View
    private var horizontalAllCoins: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 9) {
                ForEach(homeTab_ViewModel.allCoins) { coin in
                    Horizontal_InlineCoinDetail_View(coin: coin)
                        .onTapGesture {
                            withAnimation {
                                updateHoldingValue(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: DefaultValues.shared.globalCornerRadius)
                                .stroke(selectedCoin?.id == coin.id
                                        ? Color.theme.button : .clear, lineWidth: 3)
                        )
                }
            }
            .padding(.horizontal,DefaultValues.shared.gloabalPaddingValue + 2)
            .padding(.vertical,15)
        }
    }
    
    // MARK: Filter Button View
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
    
    // MARK: Top Swipe Down Gesture View
    private var swipeSheetDown: some View {
        HStack() {
            Spacer()
            RoundedRectangle(cornerRadius: 100)
                .frame(width: 30, height: 3)
                .foregroundColor(Color.theme.primaryTitle.opacity(0.6))
            Spacer()
        }
        .padding(.vertical, 9)
    }
    
    // MARK: All Textfield for portfolio view
    private var statsAndTextField: some View {
        VStack {
            HStack {
                Text("Current Price")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith2Decimals() ?? "")
            }
            .padding(7)
            Divider()
            HStack {
                Text("Holding")
                Spacer()
                TextField("Ex : 0.1", text: $userHoldings)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            .padding(7)
            Divider()
            HStack {
                Text("Current Value")
                Spacer()
                Text("\(userHoldingStats().asCurrencyWith2Decimals())")
            }
            .padding(7)
        }
        .foregroundColor(Color.theme.primaryTitle)
        .font(.headline)
        .padding(15)
        .background(Color.theme.trietaryBackground)
        .cornerRadius(DefaultValues.shared.globalCornerRadius)
        .padding(.horizontal,DefaultValues.shared.gloabalPaddingValue)
    }
    
    // MARK: Add to portfolio Button View
    private var addButton: some View {
        Button {
            homeTab_ViewModel.portfolio_CoreDataService.addCoin(coin: selectedCoin!, holdingAmount: Double(userHoldings) ?? 0)
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("ADD TO WALLET")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.secondaryBackground)
                .padding(10)
                .padding(.horizontal, 10)
                .frame(maxWidth: .infinity)
                .background(Color.theme.button)
                .cornerRadius(100)
                .padding(DefaultValues.shared.gloabalPaddingValue)
                .padding(.horizontal, 2)
        }
    }
    
    // MARK: User Holding Stats
    func userHoldingStats() -> Double {
        if selectedCoin != nil {
            return (selectedCoin?.currentPrice ?? 0) * (Double(userHoldings) ?? 0)
        }
        return 0
    }
    
    func disableButton() -> Bool {
        if selectedCoin != nil && !userHoldings.isEmpty {
            return false
        }
        return true
    }
    
    func updateHoldingValue(coin: Coin_DataModel) {
        selectedCoin = coin
        
        if let portfolioCoin = homeTab_ViewModel.userPortfolioCoins
            .first(where: { $0.id == coin.id} ), let holding = portfolioCoin.userCurrentHolding {
            userHoldings = String(holding)
        } else {
            userHoldings = ""
        }
    }
}

struct AddToPortfolio_View_Previews: PreviewProvider {
    static var previews: some View {
        AddToPortfolio_View()
            .environmentObject(HomeTab_ViewModel())
    }
}
