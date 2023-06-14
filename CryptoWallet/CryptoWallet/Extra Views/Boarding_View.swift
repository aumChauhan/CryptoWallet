import SwiftUI

struct Boarding_View: View {
    
    @AppStorage("showBoarding") var showBoarding: Bool = true
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Image("appIconForView")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                    Spacer()
                }
                
                Text("Welcome To \nCryptoWallet")
                    .foregroundColor(Color.theme.primaryTitle)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // MARK: 1st
                HStack(alignment: .top, spacing: 12) {
                    IconView(imageName: "lock.fill", bgColor: .green)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Secure Wallet")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.primaryTitle)
                        
                        Text("Our app provides a secure wallet to store your cryptocurrencies. Your private keys are stored locally on your device, ensuring that only you have access to your funds.")
                            .font(.subheadline)
                            .foregroundColor(Color.theme.secondaryTitle)
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(.vertical, 1)
                
                // MARK: 2nd
                HStack(alignment: .top, spacing: 12) {
                    IconView(imageName: "bitcoinsign.circle.fill", bgColor: .orange)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Multiple Cryptocurrencies")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.primaryTitle)
                        
                        Text("CryptoWallet supports a wide range of cryptocurrencies")
                            .font(.subheadline)
                            .foregroundColor(Color.theme.secondaryTitle)
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(.top, 14)
                
                // MARK: 3rd
                HStack(alignment: .top, spacing: 12) {
                    IconView(imageName: "clock.arrow.2.circlepath", bgColor: .blue)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Real-Time Portfolio Tracking")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.primaryTitle)
                        
                        Text("Stay updated on the value of your cryptocurrency investments with our real-time portfolio tracking feature. ")
                            .font(.subheadline)
                            .foregroundColor(Color.theme.secondaryTitle)
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(.vertical, 14)
                Spacer()
                
                HStack {
                    Spacer()
                    Button {
                        showBoarding = false
                    } label: {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(Color.theme.background)
                            .padding(14)
                            .frame(maxWidth: .infinity)
                            .background(Color.theme.button)
                            .cornerRadius(17)
                    }
                    Spacer()
                }
                .padding(.top, 20)
            }
            Spacer()
        }
        .padding(35)
        .background(Color.theme.secondaryBackground)
    }
}

struct IconView: View {
    let imageName: String
    let bgColor: Color
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.title2)
                .padding(1)
                .foregroundColor(.white)
            
        }
        .frame(width: 40, height: 40)
        .background(bgColor)
        .cornerRadius(13)
        .padding(.top, 2)
        
    }
}

struct Boarding_View_Previews: PreviewProvider {
    static var previews: some View {
        Boarding_View()
    }
}
