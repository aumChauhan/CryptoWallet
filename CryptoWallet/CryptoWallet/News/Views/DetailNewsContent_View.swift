import SwiftUI

struct DetailNewsContent_View: View {
    
    let article: Article
    @State private var scrollViewContentOffset = CGFloat(0)
    @State private var scrollPosition: CGFloat = 0
    @State private var showMore: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Divider()
            // MARK: Description Title
            Text("Description")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(Color.theme.primaryTitle)
            
            // MARK: Article Description
            Text(article.description ?? "")
                .foregroundColor(Color.theme.secondaryTitle)
                .fontWeight(.medium)
            
            Divider()
            // MARK: Article Title
            Text("Article")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(Color.theme.primaryTitle)
            
            // MARK: Article Contnent
            Text(article.content ?? "")
                .foregroundColor(Color.theme.secondaryTitle)
                .fontWeight(.medium)
            
            // MARK: Article Link
            if let url = URL(string: article.url) {
                Link(destination: url) {
                    LinkView(title: "Read Full Article Here", imageName: "safari.fill", isSystemImage: true)
                        .padding(.horizontal, -10)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct DetailNewsContent_View_Previews: PreviewProvider {
    static var previews: some View {
        DetailNewsContent_View(article: DefaultValues.shared.article)
    }
}
