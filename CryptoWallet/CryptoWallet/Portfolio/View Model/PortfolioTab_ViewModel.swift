import Foundation
import Combine
import SwiftUI

class PortfolioTab_ViewModel: ObservableObject {
    
    var marketStatsCoinDataService = MarketStats_DataService()
    @Published var marketStatsForPortfolio: [MarketPlaceStatistics_DataModel] = []
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        appendData()
    }
    
    func appendData() {
        // MARK: Appending Market Stats to 'self.marketStats'
        marketStatsCoinDataService.$marketStats
            .map({ (returnedMarketStats) -> [MarketPlaceStatistics_DataModel] in
                var stats: [MarketPlaceStatistics_DataModel] = []
                
                guard let returnStats = returnedMarketStats else {
                    return stats
                }
                
                let volume = MarketPlaceStatistics_DataModel(title: "24h Volume", value: returnStats.volume)
                let btcDominance = MarketPlaceStatistics_DataModel(title: "BitCoin Dominance", value: returnStats.btcDominance)
                
                stats.append(contentsOf: [volume, btcDominance])
                
                return stats
            })
            .sink { [weak self] returnStats in
                withAnimation {
                    self?.marketStatsForPortfolio = returnStats
                }
            }
            .store(in: &cancellables)
    }
    
}

