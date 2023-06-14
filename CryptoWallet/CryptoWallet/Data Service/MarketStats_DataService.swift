import Foundation
import Combine

class MarketStats_DataService {
    
    @Published var marketStats: MarketStats_DataModel? = nil
    var download_MarketStats_DataUtility_Subscription: AnyCancellable?
    
    init() {
        getStats()
    }
    
    func getStats() {
        let urlString = "https://api.coingecko.com/api/v3/global"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        download_MarketStats_DataUtility_Subscription =
        Download_NetworkUtility.downloadPublisher(url: url)
            .decode(type: GlobalData_DataModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: Download_NetworkUtility.sinkCompletion,
                receiveValue: { [weak self] receivedGloabalData in
                    self?.marketStats = receivedGloabalData.data
                    self?.download_MarketStats_DataUtility_Subscription?.cancel()
                })
    }
}
