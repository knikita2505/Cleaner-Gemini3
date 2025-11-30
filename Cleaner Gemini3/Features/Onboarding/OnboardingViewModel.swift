import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var currentStep: Int = 0
    @Binding var isOnboardingCompleted: Bool
    
    init(isOnboardingCompleted: Binding<Bool>) {
        self._isOnboardingCompleted = isOnboardingCompleted
    }
    
    func nextStep() {
        if currentStep < 4 {
            withAnimation {
                currentStep += 1
            }
        } else {
            completeOnboarding()
        }
    }
    
    func skip() {
        completeOnboarding()
    }
    
    private func completeOnboarding() {
        withAnimation {
            isOnboardingCompleted = true
        }
    }
}
