import Foundation
import SwiftUI
import Combine

class CoinImage_ViewModel: ObservableObject {
    
    @Published var coinImage: UIImage? = nil
    @Published var showProgressView: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    let coin: Coin_DataModel
    let serviceManager: CoinImage_DataServie
    
    init(coin: Coin_DataModel) {
        self.coin = coin
        self.serviceManager = CoinImage_DataServie(coin: coin)
        self.showProgressView = true
        self.addImage()
    }
    
    func addImage() {
        serviceManager.$coinImage
            .sink(receiveCompletion: { [weak self] ( _ ) in
                self?.showProgressView = false
            }, receiveValue: { [weak self] returnedImage in
                self?.coinImage = returnedImage
            })
            .store(in: &cancellables)
    }

}
