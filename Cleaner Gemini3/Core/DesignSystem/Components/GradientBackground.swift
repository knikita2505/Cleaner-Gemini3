import SwiftUI

struct GradientBackground: View {
    var body: some View {
        ZStack {
            Color.backgroundMain.ignoresSafeArea()
            
            // Aurora effect
            GeometryReader { proxy in
                Circle()
                    .fill(Color.primaryBlue.opacity(0.2))
                    .frame(width: 300, height: 300)
                    .blur(radius: 60)
                    .offset(x: -50, y: -100)
                
                Circle()
                    .fill(Color.primaryPurple.opacity(0.2))
                    .frame(width: 250, height: 250)
                    .blur(radius: 60)
                    .offset(x: proxy.size.width - 200, y: 100)
            }
        }
    }
}

struct GradientBackground_Previews: PreviewProvider {
    static var previews: some View {
        GradientBackground()
    }
}
