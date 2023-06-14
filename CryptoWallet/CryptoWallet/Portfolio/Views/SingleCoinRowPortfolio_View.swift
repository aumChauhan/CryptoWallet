import SwiftUI

struct SingleCoinRowPortfolio_View: View {
    
    var coin: Coin_DataModel
    @State var toogleOptions: Bool = false
    @State var toogleEditSheet: Bool = false
    @State var editHoldingAmount: String = ""
    
    @EnvironmentObject private var homeTab_ViewModel: HomeTab_ViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                coinImageLeading
                
                middleLayer
                
                Spacer()
                
                trialingLayer
            }
            
            if toogleOptions {
                editOptionsButtons
            }
            
        }
        .padding(DefaultValues.shared.gloabalInsidePaddingValue)
        .background(Color.theme.trietaryBackground)
        .cornerRadius(DefaultValues.shared.globalCornerRadius)
        .padding(.horizontal,DefaultValues.shared.gloabalPaddingValue)
        .onTapGesture {
            withAnimation(.spring()) {
                toogleOptions.toggle()
            }
        }
        
        // MARK: Edit Sheet View
        .sheet(isPresented: $toogleEditSheet) {
            editSheetVieew
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
        
    }
}

extension SingleCoinRowPortfolio_View {
    // MARK: Coin Image View
    private var coinImageLeading: some View {
        VStack(spacing: 0) {
            CoinImage_View(coin: coin)
                .frame(width: 47, height: 47)
        }
    }
    
    // MARK: Coin Details
    private var middleLayer: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            HStack(alignment: .bottom, spacing: 10) {
                // MARK: Coin Name
                Text("\(coin.symbol.uppercased())")
                    .font(.system(.headline, design: .none, weight: .bold))
                
                // MARK: Price Change %
                HStack(alignment: .center, spacing: 3) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .font(.caption2)
                        .rotationEffect(
                            Angle(degrees: (coin.priceChangePercentage24H ?? 0) >= 0 ? 0 : 180 )
                        )
                    Text("\(coin.priceChangePercentage24H?.asPercentString() ?? "")")
                        .font(.system(.footnote, design: .none, weight: .regular))
                }
                .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.CustomGreen : Color.theme.CustomRed)
            }
            
            // MARK: Current Price
            Text("\(coin.currentPrice.asCurrencyWith2Decimals())")
                .font(.system(.subheadline, design: .none, weight: .regular))
        }
        .foregroundColor(Color.theme.secondaryTitle)
        .padding(.horizontal, 10)
        
    }
    
    private var trialingLayer: some View {
        VStack(alignment: .trailing, spacing: 2) {
            // MARK: Total Value of current holding
            Text("\(coin.currentHoldingValue.asCurrencyWith2Decimals())")
                .font(.system(.callout, design: .none, weight: .semibold))
            
            // MARK: Coin Holdings
            Text("\((coin.userCurrentHolding ?? 0).asNumberString())")
                .font(.system(.subheadline, design: .none, weight: .regular))
        }
        .foregroundColor(Color.theme.secondaryTitle)
        .padding(.horizontal, 10)
    }
    
    // MARK: Drop Down Edit Options View
    private var editOptionsButtons: some View {
        HStack(alignment: .center, spacing: 0) {
            // MARK: Cancel Button
            Button {
                withAnimation(.spring()) {
                    toogleOptions.toggle()
                }
            } label: {
                Text("Cancel")
                    .modifier(PortfolioTab_EditButtonModifier(foregroundColor: .gray, backgroundColor: .gray.opacity(0.2)))
            }
            
            Spacer()
            // MARK: Edit Button
            Button {
                toogleEditSheet.toggle()
                editHoldingAmount = String(coin.userCurrentHolding ?? 0)
            } label: {
                Text("Edit")
                    .modifier(PortfolioTab_EditButtonModifier(foregroundColor: Color("button").opacity(0.75), backgroundColor: Color("button").opacity(0.1)))
            }
            
            Spacer()
            // MARK: Delete Button
            Button {
                withAnimation {
                    homeTab_ViewModel.deleteCoinFromCoreData(coin: coin)
                }
            } label: {
                Text("Delete")
                    .modifier(PortfolioTab_EditButtonModifier(foregroundColor: Color.theme.CustomRed.opacity(0.75), backgroundColor: Color.theme.CustomRed.opacity(0.1)))
            }
        }
        .font(.callout)
        .transition(.opacity)
        .padding(.top, 15)
        .padding(.bottom, 4)
        .frame(maxWidth: .infinity)
    }
    
    // MARK: Edit Portfolio View
    var editSheetVieew: some View {
        VStack(spacing: 15) {
            // MARK: Sheet Heading
            HStack {
                Spacer()
                Text("Edit Holdings")
                    .font(.headline)
                    .foregroundColor(Color.theme.primaryTitle)
                Spacer()
            }
            .padding(5)
            
            // MARK: Coin Detail
            SingleCoinRow_View(coin: coin)
            
            // MARK: TextField and Add Button
            HStack {
                TextField("", text: $editHoldingAmount)
                    .padding(.leading, 10)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.decimalPad)
                    .foregroundColor(Color.theme.primaryTitle)
                    .font(.headline)
                
                // MARK: Add Button
                Button {
                    homeTab_ViewModel.editCoinFromCoreData(coin: coin, amount: Double(editHoldingAmount) ?? 0)
                    toogleEditSheet.toggle()
                } label: {
                    Image(systemName: "checkmark")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.theme.background)
                        .modifier(SearchBarBackground_Modifier(backgroundColor: Color.theme.button))
                }
            }
            .padding(11)
            .background(Color.theme.trietaryBackground)
            .cornerRadius(23)
            .padding(.horizontal,DefaultValues.shared.gloabalPaddingValue)
            
            Spacer()
        }
        .padding(10)
        .padding(.top, 10)
        .background(Color.theme.background)
    }
}

// MARK: Portfolio Tab Drop Down Edit Buttons Modifier
struct PortfolioTab_EditButtonModifier: ViewModifier {
    let foregroundColor: Color
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(foregroundColor)
            .padding(8)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(100)
    }
}

struct SingleCoinRowPortfolio_View_Previews: PreviewProvider {
    static var previews: some View {
        SingleCoinRowPortfolio_View(coin: debugPreview.coin)
    }
}
