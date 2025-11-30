import SwiftUI

struct RootView: View {
    enum AppState: String {
        case onboarding
        case permissions
        case paywall
        case dashboard
    }
    
    @AppStorage("appState") private var appStateRaw: String = AppState.onboarding.rawValue
    
    var appState: Binding<AppState> {
        Binding(
            get: { AppState(rawValue: appStateRaw) ?? .onboarding },
            set: { appStateRaw = $0.rawValue }
        )
    }
    
    var body: some View {
        Group {
            switch appState.wrappedValue {
            case .onboarding:
                OnboardingView(isOnboardingCompleted: Binding(
                    get: { false },
                    set: { if $0 { appState.wrappedValue = .permissions } }
                ))
            case .permissions:
                PermissionsView(isPermissionsCompleted: Binding(
                    get: { false },
                    set: { if $0 { appState.wrappedValue = .paywall } }
                ))
            case .paywall:
                PaywallView(isPaywallCompleted: Binding(
                    get: { false },
                    set: { if $0 { appState.wrappedValue = .dashboard } }
                ))
            case .dashboard:
                DashboardView()
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
