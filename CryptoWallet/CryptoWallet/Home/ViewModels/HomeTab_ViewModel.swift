import Foundation
import Combine
import SwiftUI

class HomeTab_ViewModel: ObservableObject {
    
    @Published var allCoins: [Coin_DataModel] = []
    @Published var userPortfolioCoins: [Coin_DataModel] = []
    @Published var searchFilterString: String = ""
    @Published var marketStats: [MarketPlaceStatistics_DataModel] = []
    
    private let homeCoinDataService = HomeTab_DataService()
    private let marketStatsCoinDataService = MarketStats_DataService()
    let portfolio_CoreDataService = UserPortfolio_CoreDataService()
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addData()
    }
    
    func addData() {
        
        // MARK: Append and filter coins to 'self.allCoins'
        $searchFilterString
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .combineLatest(homeCoinDataService.$allCoins)
            .map { (userString, allCoins) -> [Coin_DataModel] in
                if userString.isEmpty {
                    return allCoins
                }
                return allCoins.filter { (coin) -> Bool in
                    return coin.name.lowercased().contains(userString.lowercased()) ||
                    coin.id.lowercased().contains(userString.lowercased()) ||
                    coin.symbol.lowercased().contains(userString.lowercased())
                }
            }
            .sink { [weak self] filteredCoins in
                withAnimation {
                    self?.allCoins = filteredCoins
                }
            }
            .store(in: &cancellables)
        
        // MARK: Append Market Stats to 'self.marketStats'
        marketStatsCoinDataService.$marketStats
            .map({ (returnedMarketStats) -> [MarketPlaceStatistics_DataModel] in
                
                var stats: [MarketPlaceStatistics_DataModel] = []
                
                guard let returnStats = returnedMarketStats else {
                    return stats
                }
                
                let marketCap = MarketPlaceStatistics_DataModel(title: "Market Cap", value: returnStats.marketCap, percentageChange: returnStats.marketCapChangePercentage24HUsd)
                let volume = MarketPlaceStatistics_DataModel(title: "24h Volume", value: returnStats.volume)
                let btcDominance = MarketPlaceStatistics_DataModel(title: "Bitcoin Dominance", value: returnStats.btcDominance)
                
                stats.append(contentsOf: [marketCap, volume, btcDominance])
                
                return stats
            })
            .sink { [weak self] returnStats in
                withAnimation {
                    self?.marketStats = returnStats
                }
            }
            .store(in: &cancellables)
        
        
        // MARK: Core Data
        $allCoins
            .combineLatest(portfolio_CoreDataService.$savedEntitiesArrays)
            .map { (allCoinsArray, entitysArray) -> [Coin_DataModel] in
                allCoinsArray
                    .compactMap { coin -> Coin_DataModel? in
                        guard let entity = entitysArray
                            .first(where: { entity in
                                entity.coinID == coin.id
                            }) else {
                            return nil
                        }
                        return coin.updateHolding(amount: entity.userAmountHolding)
                    }
            }
            .sink { [weak self] returnedCoins in
                withAnimation {
                    self?.userPortfolioCoins = returnedCoins
                }
            }
            .store(in: &cancellables)
    }
    
    func deleteCoinFromCoreData(coin: Coin_DataModel) {
        portfolio_CoreDataService.delete2(coin: coin)
    }
    
    func editCoinFromCoreData(coin: Coin_DataModel, amount: Double) {
        portfolio_CoreDataService.update(coin: coin, amount: amount)
    }
    
    func reloadData() {
        addData()
        homeCoinDataService.downloadCoins()
    }
    
    // MARK: Sorting Data on 'self.allCoins'
    @Published var trackSortPrice: Bool = true
    @Published var trackSortPrice_Percentage24h: Bool = true
    @Published var trackSort_userPortfolioHolding: Bool = true
    
    func mainCoinPriceSortButton() {
        if trackSortPrice {
            allCoins.sort(by: {$0.currentPrice > $1.currentPrice})
            self.trackSortPrice = false
        } else {
            allCoins.sort(by: {$0.currentPrice < $1.currentPrice})
            self.trackSortPrice = true
        }
    }
    
    func sortPercentageChange24h() {
        if trackSortPrice_Percentage24h {
            allCoins.sort(by: {$0.priceChange24H ?? 0 > $1.priceChange24H ?? 0})
            self.trackSortPrice_Percentage24h = false
        } else {
            allCoins.sort(by: {$0.priceChange24H ?? 0 < $1.priceChange24H ?? 0})
            self.trackSortPrice_Percentage24h = true
        }
    }
    
    func sortuserHolding() {
        if trackSort_userPortfolioHolding {
            userPortfolioCoins.sort(by: {$0.currentHoldingValue > $1.currentHoldingValue})
            self.trackSort_userPortfolioHolding = false
        } else {
            userPortfolioCoins.sort(by: {$0.currentHoldingValue < $1.currentHoldingValue})
            self.trackSort_userPortfolioHolding = true
        }
    }
}
