import SwiftUI

struct SingleRow_Setting_View<Content:View>: View {
    
    @State var showDetail: Bool = false
    
    let title: String
    let imageName: String
    let content: Content
    
    init(title: String, imageName: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.imageName = imageName
        self.content = content()
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 9) {
                // MARK: Setting Icon
                Circle()
                    .foregroundColor(Color.theme.button)
                    .frame(width: 30, height: 30)
                    .overlay {
                        Image(systemName: imageName)
                            .foregroundColor(Color.theme.background)
                            .font(.subheadline)
                            .padding(5)
                    }
                
                // MARK: Setting Title
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color.theme.secondaryTitle)
                    .fontWeight(.semibold)
                
                Spacer()
                
                // MARK: Drop Down Button
                NavigationViewIcon()
                    .rotationEffect(Angle(degrees: showDetail ? 270 : 90))
                    .onTapGesture {
                        withAnimation {
                            showDetail.toggle()
                        }
                    }
            }
            
            // MARK: Content View
            if showDetail {
                Divider()
                    .padding(.horizontal, 9)
                
                content
                    .padding(.horizontal, 9)
                    .padding(.top, 5)
            }
            
        }
        .padding(DefaultValues.shared.gloabalInsidePaddingValue + 3)
        .frame(maxWidth: .infinity)
        .background(Color.theme.trietaryBackground)
        .cornerRadius(DefaultValues.shared.globalCornerRadius)
        .padding(.horizontal,DefaultValues.shared.gloabalPaddingValue)
    }
}

