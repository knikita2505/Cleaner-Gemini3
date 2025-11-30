import SwiftUI

struct OnboardingStepView: View {
    let title: String
    let subtitle: String
    let imageName: String
    let isLastStep: Bool
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // Illustration Placeholder
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 280, height: 280)
                    .blur(radius: 20)
                
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.white)
            }
            .padding(.bottom, 40)
            
            VStack(spacing: 16) {
                Text(title)
                    .font(.titleL)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(subtitle)
                    .font(.bodyL)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 20)
            }
            
            Spacer()
            
            PrimaryButton(title: "Continue", action: action)
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
        }
        .padding(.top, 60)
    }
}

struct OnboardingStepView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.auroraGradient.ignoresSafeArea()
            OnboardingStepView(
                title: "Welcome to Cleaner",
                subtitle: "Clean up your library and save space.",
                imageName: "sparkles",
                isLastStep: false,
                action: {}
            )
        }
    }
}
