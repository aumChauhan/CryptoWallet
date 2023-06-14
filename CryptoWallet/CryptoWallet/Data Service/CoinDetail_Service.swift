import Foundation
import Combine

class CoinDetail_Service {
    
    @Published var allCoinDetails: CoinDetail_DataModel? = nil
    var download_CoinDetail_DataUtility_Subscription: AnyCancellable?
    var coin: Coin_DataModel
    
    init(coin: Coin_DataModel) {
        self.coin = coin
        downloadCoinDetails()
    }
    
    func downloadCoinDetails() {
        let urlString =
        "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        download_CoinDetail_DataUtility_Subscription =
        Download_NetworkUtility.downloadPublisher(url: url)
            .decode(type: CoinDetail_DataModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
        
            .sink(
                receiveCompletion: Download_NetworkUtility.sinkCompletion,
                receiveValue: { [weak self] receivedCoinsDetail in
                    self?.allCoinDetails = receivedCoinsDetail
                    self?.download_CoinDetail_DataUtility_Subscription?.cancel()
                })
    }
}
