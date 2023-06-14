import SwiftUI

struct NewsHeadline_View: View {
    
    let article: Article
    let showNavigationButton: Bool
    
    @State var showDetail: Bool = false
    
    // MARK: User Default
    @AppStorage("showAuthorNameNewsTab") var showAuthorNameNewsTab: Bool = true
    
    init(article: Article, showNavigationButton: Bool) {
        self.article = article
        self.showNavigationButton = showNavigationButton
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 3) {
                VStack(alignment: .leading, spacing: 9) {
                    // MARK: Article Heading
                    Text(article.title)
                        .foregroundColor(Color.theme.primaryTitle)
                        .fontWeight(.semibold)
                    
                    if showAuthorNameNewsTab {
                        // MARK: Author Name
                        Text("Author : \(article.author ?? "Unknown")")
                            .font(.callout)
                            .foregroundColor(Color.theme.secondaryTitle)
                            .fontWeight(.medium)
                    }
                }
                Spacer()
                if showNavigationButton {
                    // MARK: Show Article Button View
                    NavigationViewIcon()
                        .rotationEffect(Angle(degrees: showDetail ? 270 : 90))
                        .onTapGesture {
                            withAnimation {
                                showDetail.toggle()
                            }
                        }
                        .padding(.top, 4)
                }
            }
            if showDetail {
                // MARK: Articles Detail View
                DetailNewsContent_View(article: article)
            }
        }
        .padding(DefaultValues.shared.gloabalInsidePaddingValue + 3)
        .frame(maxWidth: .infinity)
        .background(Color.theme.trietaryBackground)
        .cornerRadius(DefaultValues.shared.globalCornerRadius)
        .padding(.horizontal,DefaultValues.shared.gloabalPaddingValue)
    }
}

struct NewsHeadline_View_Previews: PreviewProvider {
    static var previews: some View {
        NewsHeadline_View(article: DefaultValues.shared.article, showNavigationButton: true)
    }
}
