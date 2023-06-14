import Foundation
import Combine
import SwiftUI

class NewsTab_ViewModel: ObservableObject {
    
    @Published var allNews: [Article] = []
    
    let instance = NewsTab_DataService()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getNews()
    }
    
    func getNews() {
        instance.$allNews
            .sink(receiveValue: { [weak self] returedNews in
                withAnimation {
                    self?.allNews = returedNews
                }
            })
            .store(in: &cancellables)
    }
}

