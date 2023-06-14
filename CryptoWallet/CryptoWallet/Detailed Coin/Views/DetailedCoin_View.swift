import SwiftUI

// MARK: Coin Description Title View Modifier
struct SubTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(Color.theme.primaryTitle)
            .padding(.leading, 8)
    }
}

struct DetailedCoin_View: View {
    
    var coin: Coin_DataModel
    @StateObject var viewModel: DetailCoin_ViewModel
    
    @State private var scrollViewContentOffset = CGFloat(0)
    @State private var scrollPosition: CGFloat = 0
    @State private var showMore: Bool = false
    
    init(coin: Coin_DataModel) {
        self.coin = coin
        _viewModel = StateObject(wrappedValue: DetailCoin_ViewModel(coin: coin))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            headerAndContent
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
}

extension DetailedCoin_View {
    
    private var headerAndContent: some View {
        ZStack(alignment: .top) {
            
            trackableScroll
            
            // MARK: Navigation Title
            CustomNavigatedBar_View(coin: coin)
                .background(
                    scrollPosition < 25 ? Color.black.opacity(0.0) : Color.theme.secondaryBackground
                )
        }
        .background(Color.theme.background)
    }
    
    // MARK: Scroll View Main Content
    private var trackableScroll: some View {
        VStack(alignment: .center, spacing: 0) {
            
            CustomNavigatedBar_View(coin: coin).opacity(0.0) // For White Space
            
            TrackableScrollView(.vertical, showIndicators: false, contentOffset: $scrollViewContentOffset,content: {
                
                // MARK: Main Content
                allDetails
            })
            .onChange(of: scrollViewContentOffset, perform: { value in
                withAnimation(.spring()) {
                    scrollPosition = scrollViewContentOffset
                }
            })
        }
    }
    
    // MARK: All Description of coins
    private var allDetails: some View {
        VStack(spacing: 18) {
            description
            
            coinOverView
            
            additionalInfo
            
            links
        }
        .padding(DefaultValues.shared.gloabalPaddingValue)
    }
    
    // MARK: Description View
    private var description: some View {
        VStack(alignment: .leading, spacing: 10) {
            // MARK: Description Title
            Text("Description")
                .modifier(SubTitleModifier())
            
            // MARK: Description Content
            HStack {
                VStack(alignment: .leading){
                    Text(viewModel.coinDetail?.description?.en?.removingHTMLOccurances ?? "Description Not Provided")
                        .lineLimit(showMore ? nil : 4)
                        .foregroundColor(Color.theme.secondaryTitle)
                    
                    // MARK: Read More/Less Button
                    Button {
                        withAnimation(.spring()) {
                            showMore.toggle()
                        }
                    } label: {
                        Text(showMore ? "Read Less" : "Read More")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundColor(Color.theme.button)
                            .padding(.vertical, 2)
                    }
                }
            }
            .multilineTextAlignment(.leading)
            .padding(DefaultValues.shared.gloabalInsidePaddingValue + 2)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.theme.trietaryBackground)
            .cornerRadius(DefaultValues.shared.globalCornerRadius)
            
        }
    }
    
    // MARK: Coin OverView
    private var coinOverView: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // MARK: Coin OverView Title
            Text("Overview")
                .modifier(SubTitleModifier())
            
            HStack {
                // MARK: Current Price
                StatsView(title: "Current Price", value: "$\(coin.currentPrice)", percentageChange: coin.priceChangePercentage24H)
                
                // MARK: Market Capitialization
                StatsView(title: "Market Capitalization", value: "$\(coin.marketCap?.formattedWithAbbreviations() ?? "0")", percentageChange: coin.priceChangePercentage24H)
            }
            
            HStack {
                // MARK: Coin Rank
                StatsView(title: "Rank", value: "\(coin.rank)")
                
                // MARK: Volume
                StatsView(title: "Volume", value: "$\(coin.totalVolume?.formattedWithAbbreviations()  ?? "0")")
            }
            
        }
    }
    
    // MARK: Coin Additional Info
    private var additionalInfo: some View {
        VStack(alignment: .leading, spacing: 10) {
            // MARK: Title
            Text("Additional Information")
                .modifier(SubTitleModifier())
            
            HStack {
                // MARK: 24h High
                StatsView(title: "24h High", value: "$\(coin.high24H?.formattedWithAbbreviations() ?? "0")")
                
                // MARK: 24h Low
                StatsView(title: "24h Low", value: "$\(coin.low24H?.formattedWithAbbreviations() ?? "0")")
            }
            
            HStack {
                // MARK: Price Change
                StatsView(title: "24h Price Change", value: "$\(coin.priceChange24H?.formattedWithAbbreviations() ?? "")", percentageChange: coin.priceChangePercentage24H)
                
                // MARK: Capital Change
                StatsView(title: "24h Cap Change", value: "$\(coin.marketCapChange24H?.formattedWithAbbreviations() ?? "")", percentageChange: coin.marketCapChangePercentage24H)
            }
            
            HStack {
                // MARK: Hashing Algorith
                StatsView(title: "Hashing Algorithm", value: "\(viewModel.coinDetail?.hashingAlgorithm ?? "Not Specified")")
                
            }
        }
    }
    
    // MARK: LINKS
    private var links: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Links")
                .modifier(SubTitleModifier())
            
            HStack {
                // MARK: Reddit Link
                if let url = URL(string: viewModel.coinDetail?.links?.subredditURL ?? "") {
                    Link(destination: url) {
                        LinkView(title: "Reddit", imageName: "redditIcon", isSystemImage: false)
                    }
                }
                
                // MARK: Coin Link
                if let url2 = URL(string: viewModel.coinDetail?.links?.homepage?.first ?? "") {
                    Link(destination: url2) {
                        LinkView(title: "URL", imageName: "safari", isSystemImage: true)
                    }
                }
                
            }
        }
    }
}

struct DetailedCoin_View_Previews: PreviewProvider {
    static var previews: some View {
        DetailedCoin_View(coin: debugPreview.coin)
    }
}
