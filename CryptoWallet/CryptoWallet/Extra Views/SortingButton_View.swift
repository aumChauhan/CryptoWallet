import SwiftUI

struct SortingButton_View: View {
    @EnvironmentObject private var homeTab_ViewModel: HomeTab_ViewModel
    let buttonTitle: String
    let sortType: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "arrow.up.arrow.down")
                .font(.footnote)
            Text("\(buttonTitle)")
            Image(systemName: sortType ? "chevron.up" : "chevron.down")
                .font(.footnote)
        }
    }
}

