import SwiftUI

struct TabModel: Hashable {
    let iconName:String
    let title:String
}

struct CustomTabBar_View: View {
    
    @Namespace var namepsace
    @Binding var tabSelection: TabModel
    
    @State var arrayItems: [TabModel] = [
        TabModel(iconName: "house.fill", title: "Home"),
        TabModel(iconName: "person.fill", title: "Portfolio"),
        TabModel(iconName: "newspaper.fill", title: "News"),
        TabModel(iconName: "gear", title: "Setting")
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(arrayItems, id: \.self) { tab in
                Spacer()
                ZStack {
                    if tabSelection == tab {
                        // MARK: Selected Tab Background
                        RoundedRectangle(cornerRadius: 40)
                            .foregroundColor(Color.theme.tabBackground)
                            .frame(height: 40)
                            .matchedGeometryEffect(id: "Selectedtab", in: namepsace)
                    }
                    HStack(spacing: 6) {
                        // MARK: Tab Icon
                        Image(systemName: tab.iconName)
                            .font(.title3)
                            .foregroundColor(Color.theme.icon)
                        if tabSelection == tab {
                            // MARK: Tab Title
                            Text(tab.title)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.theme.icon)
                        }
                    }
                    .padding(.horizontal, 10)
                    .foregroundColor(tabSelection == tab ? Color.theme.primaryTitle : Color.theme.primaryTitle)
                    .cornerRadius(20)
                    .onTapGesture {
                        // MARK: Tab Switcher
                        withAnimation(.spring()) {
                            tabSelection = tab
                        }
                    }
                }
                Spacer()
            }
        }
        .padding(.horizontal, DefaultValues.shared.gloabalPaddingValue)
        .padding(.top, DefaultValues.shared.gloabalPaddingValue - 5)
        .padding(.bottom, DefaultValues.shared.gloabalPaddingValue - 9)
        .background(Color.theme.secondaryBackground)
    }
}

struct CustomTabBar_View_Previews: PreviewProvider {
    
    @State static var tabSelection2: TabModel = TabModel(iconName: "house.fill", title: "Home")
    
    static var previews: some View {
        CustomTabBar_View(tabSelection: $tabSelection2)
    }
}
