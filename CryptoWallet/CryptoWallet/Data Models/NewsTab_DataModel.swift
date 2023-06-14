// MARK: API Source : https://newsapi.org/
// MARK: API KEY: https://newsapi.org/v2/everything?q=crypto&apiKey=API_KEY

import Foundation

struct NewsTab_DataModel: Codable {
    var articles: [Article]
}

struct Article: Codable {
    let title: String
    let author: String?
    let description: String?
    let url: String
    let urlToImage: String?
    let content: String?
}
