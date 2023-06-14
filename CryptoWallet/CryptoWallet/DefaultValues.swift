import Foundation
import SwiftUI

class DefaultValues {
    
    static let shared = DefaultValues()
    
    // MARK: FOR UI VIEW
    let gloabalPaddingValue: CGFloat = 14
    let gloabalInsidePaddingValue: CGFloat = 15
    let globalCornerRadius: CGFloat = 27
    
    // MARK: FOR DEBUGGING & TESTING
    let coin = Coin_DataModel(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
        currentPrice: 61408,
        marketCap: 1141731099010,
        marketCapRank: 1,
        fullyDilutedValuation: 1285385611303,
        totalVolume: 67190952980,
        high24H: 61712,
        low24H: 56220,
        priceChange24H: 3952.64,
        priceChangePercentage24H: 6.87944,
        marketCapChange24H: 72110681879,
        marketCapChangePercentage24H: 6.74171,
        circulatingSupply: 18653043,
        totalSupply: 21000000,
        maxSupply: 21000000,
        ath: 61712,
        athChangePercentage: -0.97589,
        athDate: "2021-03-13T20:49:26.606Z",
        atl: 67.81,
        atlChangePercentage: 90020.24075,
        atlDate: "2013-07-06T00:00:00.000Z",
        lastUpdated: "2021-03-13T23:18:10.268Z",
        sparklineIn7D: SparklineIn7D(price: [
            54019.26878317463,
            53718.060935791524,
            53677.12968669343,
            57336.828870254896
        ]),
        priceChangePercentage24HInCurrency: 3952.64,
        userCurrentHolding: 1.5)
    
    let article = Article(
        title: "Bankrupt Crypto Companies Are Fighting Over a Dwindling Pot of Money",
        author: "Joel Khalili",
        description:  "FTX’s liquidator is trying to claw back $4 billion from the estate of Genesis Global Capital, another fallen crypto business.",
        url: "https://www.wired.com/story/bankrupt-crypto-companies-fighting-over-dwindling-pot-of-money/", urlToImage: "https://media.wired.com/photos/647e82866b2fffe52ad78fc1/191:100/w_1280,c_limit/Business-Bankrupt-Crypto-Companies-1160111847.jpg",
        content: "Legal experts, though, say theyre skeptical of FTXs chances. Marc Powers, adjunct professor of law at Florida International University, who acted as counsel in the liquidation of Bernie Madoffs infam… [+3163 chars]"
    )
}
