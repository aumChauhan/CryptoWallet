import SwiftUI

struct CoinImage_View: View {
    
    @StateObject var viewModel: CoinImage_ViewModel
    
    init(coin: Coin_DataModel) {
        _viewModel = StateObject(wrappedValue: CoinImage_ViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let coinImage = viewModel.coinImage {
                Image(uiImage: coinImage)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.showProgressView {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(.gray.opacity(0.6))
            }
        }
    }
}

struct CoinImage_View_Previews: PreviewProvider {
    static var previews: some View {
        CoinImage_View(coin: debugPreview.coin)
    }
}
