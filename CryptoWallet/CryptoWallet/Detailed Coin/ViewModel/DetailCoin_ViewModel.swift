import Foundation
import Combine
import SwiftUI

class DetailCoin_ViewModel: ObservableObject {
    
    let coin: Coin_DataModel
    let instance: CoinDetail_Service
    var cancellables = Set<AnyCancellable>()
    @Published var coinDetail: CoinDetail_DataModel? = nil
    
    init(coin: Coin_DataModel) {
        self.coin = coin
        self.instance = CoinDetail_Service(coin: coin)
        self.addCoinDetails()
    }
    
    func addCoinDetails() {
        instance.$allCoinDetails
            .sink { [weak self] returnedCoinDetails in
                withAnimation {
                    self?.coinDetail = returnedCoinDetails
                    print(returnedCoinDetails as Any)
                }
            }
            .store(in: &cancellables)
    }
}
