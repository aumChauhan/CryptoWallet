import SwiftUI
import Charts

struct ChartView: View {
    
    let data: [Double]
    let maxY: Double
    let minY: Double
    let priceChange: Double
    
    init(coin: Coin_DataModel) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        priceChange = (data.last ?? 0) - (data.first ?? 0)
    }
    
    var body: some View {
        VStack {
            Chart {
                ForEach(data, id: \.self) { dt in
                    
                }
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: debugPreview.coin)
    }
}
