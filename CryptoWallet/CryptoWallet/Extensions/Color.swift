import Foundation
import SwiftUI

extension Color {
    static var theme: DefaultBlueTheme = DefaultBlueTheme()
}

struct DefaultBlueTheme {
    
    @AppStorage("colorTheme") var colorTheme: String = ""
    
    var background: Color = Color("background")
    var secondaryBackground: Color = Color("secondaryBackground")
    var trietaryBackground: Color = Color("trietaryBackground")
    var primaryTitle: Color = Color("primaryTitle")
    var secondaryTitle: Color = Color("secondaryTitle")
    var button: Color = Color("button")
    var icon: Color = Color("icon")
    var tabBackground: Color = Color("tabBackground")
    
    let CustomGreen: Color = Color("CustomGreen")
    let CustomRed: Color = Color("CustomRed")
    
    init() {
        setTheme()
    }
    
    mutating func setTheme() {
        switch colorTheme {
        case "button":
            background = Color("background")
            secondaryBackground =  Color("secondaryBackground")
            trietaryBackground = Color("trietaryBackground")
            primaryTitle = Color("primaryTitle")
            secondaryTitle = Color("secondaryTitle")
            button = Color("button")
            icon  = Color("icon")
            tabBackground = Color("tabBackground")
            
        case "buttonPurple":
            background  = Color("backgroundPurple")
            secondaryBackground = Color("secondaryBackgroundPurple")
            trietaryBackground = Color("trietaryBackgroundPurple")
            primaryTitle = Color("primaryTitlePurple")
            secondaryTitle  = Color("secondaryTitlePurple")
            button  = Color("buttonPurple")
            icon  = Color("iconPurple")
            tabBackground  = Color("tabBackgroundPurple")
            
        case "buttonGreen":
            background  =  Color("backgroundGreen")
            secondaryBackground  = Color("secondaryBackgroundGreen")
            trietaryBackground = Color("trietaryBackgroundGreen")
            primaryTitle = Color("primaryTitleGreen")
            secondaryTitle = Color("secondaryTitleGreen")
            button = Color("buttonGreen")
            icon  = Color("iconGreen")
            tabBackground = Color("tabBackgroundGreen")
            
        case "buttonRed":
            background  = Color("backgroundRed")
            secondaryBackground  = Color("secondaryBackgroundRed")
            trietaryBackground  = Color("trietaryBackgroundRed")
            primaryTitle  = Color("primaryTitleRed")
            secondaryTitle  = Color("secondaryTitleRed")
            button  = Color("buttonRed")
            icon  = Color("iconRed")
            tabBackground  = Color("tabBackgroundRed")
            
        case "buttonYellow":
            background  = Color("backgroundYellow")
            secondaryBackground  = Color("secondaryBackgroundYellow")
            trietaryBackground  = Color("trietaryBackgroundYellow")
            primaryTitle  = Color("primaryTitleYellow")
            secondaryTitle  = Color("secondaryTitleYellow")
            button  = Color("buttonYellow")
            icon  = Color("iconYellow")
            tabBackground  = Color("tabBackgroundYellow")
            
        default:
            background  = Color("background")
            secondaryBackground  = Color("secondaryBackground")
            trietaryBackground  = Color("trietaryBackground")
            primaryTitle  = Color("primaryTitle")
            secondaryTitle  = Color("secondaryTitle")
            button  = Color("button")
            icon  = Color("icon")
            tabBackground  = Color("tabBackground")
        }
    }
    
}
