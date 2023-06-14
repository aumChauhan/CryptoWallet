import Foundation
import SwiftUI

struct FontModifier: ViewModifier {

    let fontStyle : String
    
    init(fontStyle: String) {
        self.fontStyle = fontStyle
    }
    
    func body(content: Content) -> some View {
        switch fontStyle {
        case "default":
            content
                .fontDesign(.default)
        case "rounded":
            content
                .fontDesign(.rounded)
        case "serif":
            content
                .fontDesign(.serif)
        case "monospaced":
            content
                .fontDesign(.monospaced)
        default:
            content
                .fontDesign(.default)
        }
    }
}

