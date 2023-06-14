import Foundation
import Combine

class HomeTab_DataService {
    
    @Published var allCoins: [Coin_DataModel] = []
    var download_Coin_DataUtility_Subscription: AnyCancellable?
    
    init() {
        downloadCoins()
    }
    
    func downloadCoins() {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=en&precision=2"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        download_Coin_DataUtility_Subscription =
        Download_NetworkUtility.downloadPublisher(url: url)
            .decode(type: [Coin_DataModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: Download_NetworkUtility.sinkCompletion,
                receiveValue: { [weak self] receivedCoins in
                    self?.allCoins = receivedCoins
                    self?.download_Coin_DataUtility_Subscription?.cancel()
                })
        print("DEBUG: Downloading Coins")
    }
}
