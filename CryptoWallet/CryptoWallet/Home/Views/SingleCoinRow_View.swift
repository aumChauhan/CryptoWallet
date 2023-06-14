import SwiftUI

struct SingleCoinRow_View: View {
    
    let coin: Coin_DataModel
    
    // MARK: User Defaults
    @AppStorage("showPercenntageChangeHomeTab") var showPercenntageChangeHomeTab: Bool = true
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            coinImage
            
            coinDetails
            
            Spacer()
            
            NavigationViewIcon()
        }
        .padding(DefaultValues.shared.gloabalInsidePaddingValue)
        .background(Color.theme.trietaryBackground)
        .cornerRadius(DefaultValues.shared.globalCornerRadius)
        .padding(.horizontal,DefaultValues.shared.gloabalPaddingValue)
    }
}

extension SingleCoinRow_View {
    
    // MARK: Coin Image Leading Component
    private var coinImage : some View {
        CoinImage_View(coin: coin)
            .frame(width: 47, height: 47)
    }
    
    // MARK: Coin Details
    private var coinDetails : some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                // MARK: Coin Name
                Text("\(coin.symbol.uppercased())")
                    .font(.system(.headline, design: .none, weight: .bold))
                
                // MARK: From User Defaults
                if showPercenntageChangeHomeTab {
                    coinPercentageChange
                }
            }
            
            // MARK: Coin Price
            Text("\(coin.currentPrice.asCurrencyWith2Decimals())")
                .font(.system(.subheadline, design: .none, weight: .medium))
                .foregroundColor(Color.theme.secondaryTitle)
        }
        .foregroundColor(Color.theme.primaryTitle)
        .padding(.horizontal, 10)
    }
    
    // MARK: Percentage change 24h
    private var coinPercentageChange : some View {
        HStack(alignment: .center, spacing: 3) {
            Image(systemName: "arrowtriangle.up.fill")
                .font(.caption2)
                .rotationEffect(
                    Angle(degrees: (coin.priceChangePercentage24H ?? 0) >= 0 ? 0 : 180 )
                )
            
            Text("\(coin.priceChangePercentage24H?.asPercentString() ?? "0%")")
                .font(.system(.callout, design: .none, weight: .medium))
        }
        .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.CustomGreen : Color.theme.CustomRed)
    }
}

struct SingleCoinRow_View_Previews: PreviewProvider {
    static var previews: some View {
        SingleCoinRow_View(coin: debugPreview.coin)
    }
}
