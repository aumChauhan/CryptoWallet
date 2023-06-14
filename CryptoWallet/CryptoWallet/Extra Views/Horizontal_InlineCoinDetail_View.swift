import SwiftUI

// MARK: For PortfolioView
struct Horizontal_InlineCoinDetail_View: View {
    
    let coin: Coin_DataModel
    @EnvironmentObject private var homeTab_ViewModel: HomeTab_ViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            // MARK: Coin Image
            CoinImage_View(coin: coin)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    // MARK: Coin Name
                    Text("\(coin.symbol.uppercased())")
                        .font(.system(.headline, weight: .bold))
                    
                    // MARK: Coin Exists or Not
                    if homeTab_ViewModel.userPortfolioCoins
                        .first(where: { $0.id == coin.id} ) != nil {
                        Text("(Already Exists)")
                            .font(.caption2)
                    }
                    
                }
                .foregroundColor(Color.theme.primaryTitle)
                
                // MARK: Coin Name
                Text("\(coin.id.capitalized)")
                    .font(.system(.subheadline, weight: .semibold))
                    .foregroundColor(Color.theme.secondaryTitle)
            }
        }
        .padding(DefaultValues.shared.gloabalInsidePaddingValue)
        .background(Color.theme.trietaryBackground)
        .cornerRadius(DefaultValues.shared.globalCornerRadius)
    }
}

struct Horizontal_InlineCoinDetail_View_Previews: PreviewProvider {
    static var previews: some View {
        Horizontal_InlineCoinDetail_View(coin: debugPreview.coin)
            .environmentObject(HomeTab_ViewModel())
    }
}
