import SwiftUI

// MARK: Main Navigation View
struct CustomNavBar_View: View {
    
    var title: String
    @State var toogleMenu: Bool = false
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            HStack(spacing: 0) {
                // MARK: Navigation Title
                Text("\(title)")
                    .font(.system(.title, design: .rounded, weight: .semibold))
                    .padding(.horizontal, 5)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding(DefaultValues.shared.gloabalPaddingValue)
            .foregroundColor(Color.theme.primaryTitle)
        }
    }
}

// MARK: Sub Navigation View
struct CustomNavigatedBar_View: View {
    
    var coin: Coin_DataModel
    
    @State var toogleMenu: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Group {
            HStack(spacing: 8) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    // MARK: Back Button Icon
                    Image(systemName: "chevron.left")
                        .font(.headline)
                    
                    // MARK: Title
                    Text("\(coin.name.capitalized)")
                        .multilineTextAlignment(.leading)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                
                Spacer()
            }
            .padding(DefaultValues.shared.gloabalPaddingValue)
            .foregroundColor(Color.theme.primaryTitle)
        }
    }
}

struct NavigationViewIcon: View {
    var body: some View {
        Image(systemName: "chevron.right").opacity(0.5)
            .foregroundColor(.primary)
            .font(.footnote)
            .padding(5)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(100)
    }
}

struct CustomNavBar_View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CustomNavigatedBar_View(coin: debugPreview.coin)
                .navigationBarHidden(true)
        }
    }
}
