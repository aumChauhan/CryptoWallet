import SwiftUI

struct StatsView: View {
    
    var title: String
    var value: String
    var percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            // MARK: Top Components
            Text(title)
                .foregroundColor(Color.theme.secondaryTitle)
                .font(.system(.footnote, weight: .semibold))
            
            // MARK: Middle Components
            Text(value)
                .foregroundColor(Color.theme.button)
                .font(.system(.subheadline, weight: .semibold))
            
            // MARK: Bottom Components
            if (percentageChange != nil) {
                HStack(alignment: .center, spacing: 4) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .font(.caption2)
                        .rotationEffect(
                            Angle(degrees: (percentageChange ?? 0) >= 0 ? 0 : 180 )
                        )
                    
                    Text(percentageChange?.asPercentString() ?? "")
                        .font(.system(.footnote, weight: .semibold))
                }
                .foregroundColor((percentageChange ?? 0 ) >= 0 ? Color.theme.CustomGreen : Color.theme.CustomRed)
            }
        }
        .multilineTextAlignment(.leading)
        .padding(DefaultValues.shared.gloabalInsidePaddingValue)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color.theme.trietaryBackground)
        .cornerRadius(DefaultValues.shared.globalCornerRadius)
        
    }
    
}

struct LinkView: View {
    
    var title: String
    var imageName: String
    var isSystemImage: Bool
    
    init(title: String, imageName: String, isSystemImage: Bool) {
        self.title = title
        self.imageName = imageName
        self.isSystemImage = isSystemImage
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 7) {
            if isSystemImage {
                Image(systemName: imageName)
                    .foregroundColor(Color.theme.secondaryTitle)
            } else {
                Image("\(imageName)")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.theme.secondaryTitle)
            }
            
            Text(title)
                .foregroundColor(Color.theme.secondaryTitle)
                .font(.system(.subheadline, weight: .semibold))
        }
        .multilineTextAlignment(.leading)
        .padding(DefaultValues.shared.gloabalInsidePaddingValue)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color.theme.trietaryBackground)
        .cornerRadius(DefaultValues.shared.globalCornerRadius)
        
    }
    
}


struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        LinkView(title: "Reddit", imageName: "redditIcon", isSystemImage: true)
    }
}
