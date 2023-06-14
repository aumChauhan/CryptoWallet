import SwiftUI

struct CustomProgressView: View {
    
    @AppStorage("progressViewStyle") var progressViewStyle: String = "Default"
    @State var rotationAngle: Double = 0
    
    let frameHeight: CGFloat
    let timer = Timer.publish(every: 0.1,on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Spacer()
            // MARK: MacOS ProgressView
            if progressViewStyle == "MacOS" {
                Image("customProgressView")
                    .resizable()
                    .scaledToFill()
                    .frame(width: frameHeight, height: frameHeight)
                    .rotationEffect(Angle(degrees: rotationAngle))
            }
            // MARK: Default Progress View
            else if progressViewStyle == "Default" {
                Image("customProgressView2")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(Color.theme.button)
                    .frame(width: frameHeight, height: frameHeight)
                    .rotationEffect(Angle(degrees: rotationAngle))
            }
            // MARK: Default iOS Porgress View
            else {
                ProgressView()
            }
            Spacer()
        }
        .onReceive(timer) { _ in
            withAnimation {
                rotationAngle += 40
            }
        }
    }
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView(frameHeight: 50)
    }
}
