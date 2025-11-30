import SwiftUI

class PaywallViewModel: ObservableObject {
    @Published var isTrialEnabled: Bool = true
    @Published var selectedPlan: Plan = .yearly
    @Binding var isPaywallCompleted: Bool
    
    enum Plan {
        case yearly
        case weekly
    }
    
    init(isPaywallCompleted: Binding<Bool>) {
        self._isPaywallCompleted = isPaywallCompleted
    }
    
    func purchase() {
        // Simulate purchase
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.completePaywall()
        }
    }
    
    func skip() {
        completePaywall()
    }
    
    private func completePaywall() {
        withAnimation {
            isPaywallCompleted = true
        }
    }
    
    var buttonTitle: String {
        if isTrialEnabled {
            return "Try for Free"
        } else {
            return "Continue"
        }
    }
}
