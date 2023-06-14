import SwiftUI

struct MarketPlaceStatistics_View: View {
    
    let marketPlaceStatistics: MarketPlaceStatistics_DataModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            // MARK: (Title) Top Components
            Text(marketPlaceStatistics.title)
                .foregroundColor(Color.theme.secondaryTitle)
                .font(.system(.footnote, weight: .semibold))
            
            // MARK: (Values) Middle Components
            Text(marketPlaceStatistics.value)
                .foregroundColor(Color.theme.button)
                .font(.system(.subheadline, weight: .semibold))
            
            // MARK: (Percentage) Bottom Components
            if (marketPlaceStatistics.percentageChange != nil) {
                HStack(alignment: .center, spacing: 4) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .font(.caption2)
                        .rotationEffect(
                            Angle(degrees: (marketPlaceStatistics.percentageChange ?? 0) >= 0 ? 0 : 180 )
                        )
                    
                    Text(marketPlaceStatistics.percentageChange?.asPercentString() ?? "")
                        .font(.system(.footnote, weight: .semibold))
                }
                .foregroundColor((marketPlaceStatistics.percentageChange ?? 0 ) >= 0 ? Color.theme.CustomGreen : Color.theme.CustomRed)
            }
        }
        .multilineTextAlignment(.leading)
        .padding(DefaultValues.shared.gloabalInsidePaddingValue + 2)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.theme.trietaryBackground)
        .cornerRadius(DefaultValues.shared.globalCornerRadius)
        
    }
}

struct MarketPlaceStatistics_View_Previews: PreviewProvider {
    static var previews: some View {
        MarketPlaceStatistics_View(marketPlaceStatistics: debugPreview.marketPlaceRawValueWithPercentage)
    }
}
