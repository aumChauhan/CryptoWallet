import Foundation
import SwiftUI

extension String {
    /// Removes tag from string phrase
    /// ```
    /// <a> Hello </a> -> Hello
    /// ```
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
