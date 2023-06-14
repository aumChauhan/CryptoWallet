import Foundation
import Combine
import SwiftUI

class NewsTab_DataService {
    
    @AppStorage("newsGenresSelection") var newsGenresSelection: String = "Crypto"
    @Published var allNews: [Article] = []
    
    var download_News_DataUtility_Subscription: AnyCancellable?
    
    init() {
        downloadNews()
    }
    
    func downloadNews() {
        let urlString = "https://newsapi.org/v2/everything?q=\(newsGenresSelection)&apiKey=696d9abb79594a16bd61baa9685db993"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        download_News_DataUtility_Subscription =
        Download_NetworkUtility.downloadPublisher(url: url)
            .decode(type: NewsTab_DataModel.self, decoder: JSONDecoder())
            .map { $0.articles }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("API Error: \(error)")
                }
            }, receiveValue: { [weak self] articles in
                self?.allNews = articles
                self?.download_News_DataUtility_Subscription?.cancel()
            })
        print("DEBUG: Downloading News")
    }
}
