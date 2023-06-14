import SwiftUI

// MARK: Search Bar Background Modifer
struct SearchBarBackground_Modifier: ViewModifier {
    
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding(DefaultValues.shared.gloabalInsidePaddingValue - 6)
            .padding(.horizontal, DefaultValues.shared.gloabalInsidePaddingValue / 2)
            .background(backgroundColor)
            .cornerRadius(100)
    }
}

struct SearchBar_View: View, KeyboardReadable {
    
    @Binding var searchFilterString: String
    @Binding var showKeyboardDismiss: Bool
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                searchBar
                
                // MARK: Dismiss Keyboard Button
                if showKeyboardDismiss {
                    Button {
                        withAnimation {
                            UIApplication.shared.dismissKeyboard()
                            showKeyboardDismiss = true
                            searchFilterString = ""
                        }
                    } label: {
                        withAnimation {
                            Image(systemName: "keyboard.chevron.compact.down")
                                .foregroundColor(Color.gray.opacity(0.6))
                                .modifier(SearchBarBackground_Modifier(backgroundColor: Color.theme.trietaryBackground))
                                .padding(5)
                        }
                    }
                }
                
            }
            .padding(.horizontal,DefaultValues.shared.gloabalPaddingValue)
        }
    }
}

extension SearchBar_View {
    private var searchBar: some View {
        HStack(alignment: .center, spacing: 8) {
            // MARK: Leading Components (Icon)
            Image(systemName: "magnifyingglass")
                .font(.callout)
                .foregroundColor(Color.gray.opacity(0.5))
            
            // MARK: TextField
            TextField("Search", text: $searchFilterString)
                .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                    print("Is keyboard visible? ", newIsKeyboardVisible)
                    withAnimation {
                        showKeyboardDismiss = newIsKeyboardVisible
                    }
                }
                .onSubmit {
                    searchFilterString = ""
                }
            Spacer()
            
            // MARK: Clear Textfield Button
            if !searchFilterString.isEmpty {
                Button {
                    searchFilterString = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.callout)
                        .foregroundColor(Color.gray.opacity(0.5))
                }
            }
        }
        .modifier(SearchBarBackground_Modifier(backgroundColor: Color.theme.trietaryBackground))
    }
}

