import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel: OnboardingViewModel
    
    init(isOnboardingCompleted: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: OnboardingViewModel(isOnboardingCompleted: isOnboardingCompleted))
    }
    
    var body: some View {
        ZStack {
            Color.auroraGradient.ignoresSafeArea()
            
            TabView(selection: $viewModel.currentStep) {
                // Step 1: Welcome
                OnboardingStepView(
                    title: "Let's clean up your device",
                    subtitle: "Smart scanning of photos, videos, duplicates and system clutter.",
                    imageName: "sparkles",
                    isLastStep: false,
                    action: viewModel.nextStep
                )
                .tag(0)
                
                // Step 2: Benefits
                OnboardingStepView(
                    title: "Delete unwanted. Keep important.",
                    subtitle: "Accurately find duplicates, similar photos, Live and blurry shots. You decide what to keep.",
                    imageName: "photo.stack",
                    isLastStep: false,
                    action: viewModel.nextStep
                )
                .tag(1)
                
                // Step 3: System
                OnboardingStepView(
                    title: "Maximum performance every day",
                    subtitle: "Smart device analysis: battery status, heating, heavy files — everything under control.",
                    imageName: "bolt.fill",
                    isLastStep: false,
                    action: viewModel.nextStep
                )
                .tag(2)
                
                // Step 4: Trust
                OnboardingStepView(
                    title: "Designed for stable and safe operation",
                    subtitle: "Your data stays on the device. We do not send photos or videos to the server.",
                    imageName: "lock.shield.fill",
                    isLastStep: false,
                    action: viewModel.nextStep
                )
                .tag(3)
                
                // Step 5: Pre-permission
                PrePermissionView(action: viewModel.nextStep)
                    .tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: viewModel.currentStep)
            
            // Custom Page Indicator
            VStack {
                HStack(spacing: 8) {
                    ForEach(0..<5) { index in
                        Circle()
                            .fill(index == viewModel.currentStep ? Color.white : Color.white.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.top, 60)
                Spacer()
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isOnboardingCompleted: .constant(false))
    }
}
