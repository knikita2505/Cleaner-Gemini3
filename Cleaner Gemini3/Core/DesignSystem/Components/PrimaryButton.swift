import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subtitleL)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.ctaGradient)
                .cornerRadius(16)
                .shadow(color: Color.primaryBlue.opacity(0.3), radius: 10, x: 0, y: 5)
        }
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.backgroundMain.ignoresSafeArea()
            PrimaryButton(title: "Get Started", action: {})
                .padding()
        }
    }
}
