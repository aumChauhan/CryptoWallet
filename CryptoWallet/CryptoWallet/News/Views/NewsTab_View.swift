import SwiftUI

struct NewsTab_View: View {
    
    @StateObject var viewModel = NewsTab_ViewModel()
    @State private var scrollViewContentOffset = CGFloat(0)
    @Binding var scrollPosition: CGFloat
    
    // MARK: User Defaults
    @AppStorage("newsGenresSelection") var newsGenresSelection: String = "Crypto"
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            scrollTracker_NavBar
        }
        .background(Color.theme.background)
    }
}

extension NewsTab_View {
    
    // MARK: Main Content
    private var scrollTracker_NavBar: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .center, spacing: 0) {
                
                CustomNavBar_View(title: "News").opacity(0.0) // For White space
                
                TrackableScrollView(.vertical, showIndicators: false, contentOffset: $scrollViewContentOffset, content: {
                    
                    // MARK: Headline Tuples
                    LazyVStack(spacing: 10) {
                        ForEach(viewModel.allNews, id: \.title) { article in
                            NewsHeadline_View(article: article, showNavigationButton: true)
                        }
                    }
                })
                .onChange(of: scrollViewContentOffset, perform: { value in
                    withAnimation(.spring()) {
                        scrollPosition = scrollViewContentOffset
                    }
                })
                .onAppear {
                    scrollPosition = 0
                }
            }
            
            // MARK: Navigation Title, From User Defaults
            CustomNavBar_View(title: "\(newsGenresSelection) News")
                .background(
                    scrollPosition < 25 ? Color.black.opacity(0.0) : Color.theme.secondaryBackground
                )
        }
        .background(Color.theme.background)
    }
}
