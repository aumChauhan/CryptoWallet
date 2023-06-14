import SwiftUI

struct HomeTab_HeaderAndContent_View: View {
    
    @State private var scrollViewContentOffset = CGFloat(0)
    @State private var scrollPosition: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            
            scrollAndCryptoCurrencyRows_ExtendedView
            
            CustomNavBar_View(title: "Live Prices")
                .background(
                    scrollPosition < 25 ? Color.black.opacity(0.0) : Color.theme.secondaryBackground
                )
            
        }
        .background(Color.theme.background)
    }
}

extension HomeTab_HeaderAndContent_View {
    
    // MARK: Header And TrackableScroll View
    private var scrollAndCryptoCurrencyRows_ExtendedView: some View {
        VStack(alignment: .center, spacing: 0) {
            
            CustomNavBar_View(title: "Live Prices").opacity(0.0)
            
            TrackableScrollView(.vertical, showIndicators: false, contentOffset: $scrollViewContentOffset, content: {
                
                horizontalSortButtons
                
                ForEach(0..<10) { index in
                    SingleCoinRow_View(coin: DefaultValues.shared.coin)
                        .padding(0)
                }
                
            })
            .onChange(of: scrollViewContentOffset, perform: { value in
                withAnimation(.spring()) {
                    scrollPosition = scrollViewContentOffset
                }
            })
            
        }
    }
    
    // MARK: Filter Buttons
    private var horizontalSortButtons: some View {
        HStack(spacing: 0) {
            Text("Coin")
            Spacer()
            Text("Price")
        }
        .foregroundColor(Color.theme.button)
        .font(.system(.callout, design: .rounded, weight: .medium))
        .padding(.horizontal, DefaultValues.shared.gloabalPaddingValue + 10)
    }
    
}

struct HomeTab_HeaderAndContent_View_Previews: PreviewProvider {
    static var previews: some View {
        HomeTab_HeaderAndContent_View()
    }
}
