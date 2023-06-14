import SwiftUI

class StatsticsDummyData {
    static let shared = StatsticsDummyData()
    
    let fakeData: [MarketPlaceStatistics_DataModel]  = [
        MarketPlaceStatistics_DataModel(title: "Market Cap", value: "1.11Tr"),
        MarketPlaceStatistics_DataModel(title: "24h Volume", value: "1.11Bn"),
        MarketPlaceStatistics_DataModel(title: "BTC Dominance", value: "1.11Tr")
    ]
    
    let fakeData2: [MarketPlaceStatistics_DataModel]  = [
        MarketPlaceStatistics_DataModel(title: "24h Volume", value: "1.11Bn"),
        MarketPlaceStatistics_DataModel(title: "BTC Dominance", value: "1.11Bn")
    ]
}

struct HomeTab_MarketStatsticsRow_View: View {
    
    let fakeData: [MarketPlaceStatistics_DataModel]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(fakeData) { stats in
                MarketPlaceStatistics_View(marketPlaceStatistics: stats)
            }
            .padding(4)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, DefaultValues.shared.gloabalPaddingValue)
        .padding(.vertical, 6)
    }
}

struct HomeTab_MarketStatsticsRow_View_Previews: PreviewProvider {
    static var previews: some View {
        HomeTab_MarketStatsticsRow_View(fakeData: StatsticsDummyData.shared.fakeData)
    }
}
