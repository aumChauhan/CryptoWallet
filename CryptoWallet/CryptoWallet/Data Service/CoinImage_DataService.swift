import Foundation
import SwiftUI
import Combine

class CoinImage_DataServie {
    
    @Published var coinImage: UIImage? = nil
    
    var coinImage_Subscription: AnyCancellable?
    let coin: Coin_DataModel
    let imageName: String
    let folderName: String = "CryptoWallet_Cache"
    let fileManger = LocalFileManager.shared
    
    init(coin: Coin_DataModel) {
        self.coin = coin
        self.imageName = coin.id
        self.getCoinImage()
    }
    
    func getCoinImage() {
        if let savedImage = LocalFileManager.shared.fetchImage(imageName: imageName, folderName: folderName) {
            coinImage = savedImage
            print("DEBUG: FETCHING IMAGE FROM FILE MANAGER")
        } else {
            downloadCoinImage()
            print("DEBUG: DOWNLOADING IMAGE")
        }
    }
    
    func downloadCoinImage() {
        guard let url = URL(string: coin.image) else {
            return
        }
        
        coinImage_Subscription =
        Download_NetworkUtility.downloadPublisher(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data) ?? UIImage(systemName: "apple.logo")
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: Download_NetworkUtility.sinkCompletion, receiveValue: { [weak self] (receivedImage) in
                guard
                    let self = self,
                    let downloadedImage = receivedImage else {
                    return
                }
                self.coinImage = downloadedImage
                self.coinImage_Subscription?.cancel()
                // MARK: Saving to file manager
                self.fileManger.setImage(coinImage: downloadedImage, imageName: coin.id, folderName: self.folderName)
            })
    }
    
}
