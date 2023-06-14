import Foundation
import Combine

class Download_Coin_DataUtility {
    
    @Published var allCoins: [Coin_DataModel] = []
    var download_Coin_DataUtility_Subscription: AnyCancellable?
    
    init() {
        downloadCoins()
    }
    
    func downloadCoins() {
        
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=en&precision=2"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        download_Coin_DataUtility_Subscription =
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                guard
                    let response = output.response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300  else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: [Coin_DataModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] receivedCoins in
                self?.allCoins = receivedCoins
                self?.download_Coin_DataUtility_Subscription?.cancel()
            }
        
    }
    
}
