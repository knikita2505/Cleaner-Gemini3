import SwiftUI

struct PermissionsView: View {
    @StateObject private var viewModel: PermissionsViewModel
    
    init(isPermissionsCompleted: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: PermissionsViewModel(isPermissionsCompleted: isPermissionsCompleted))
    }
    
    var body: some View {
        ZStack {
            Color.backgroundMain.ignoresSafeArea()
            
            if viewModel.currentStep == .photos {
                // Reusing PrePermissionView style for consistency, but adapted
                permissionStepView(
                    icon: "photo.on.rectangle.angled",
                    title: "Allow access to your Photos",
                    subtitle: "We need this to find duplicates and large items to clean up storage.",
                    footer: "Your photos stay on device. We do not upload them.",
                    buttonTitle: "Continue",
                    action: {
                        Task { await viewModel.requestPhotosPermission() }
                    },
                    secondaryAction: nil
                )
                .transition(.opacity)
            } else {
                permissionStepView(
                    icon: "bell.badge.fill",
                    title: "Stay on top of your device health",
                    subtitle: "We'll send occasional reminders and tips. You can change this later.",
                    footer: "",
                    buttonTitle: "Enable notifications",
                    action: {
                        Task { await viewModel.requestNotificationPermission() }
                    },
                    secondaryAction: {
                        Button(action: viewModel.skipNotifications) {
                            Text("Not now")
                                .font(.bodyM)
                                .foregroundColor(.white.opacity(0.6))
                        }
                    }
                )
                .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: viewModel.currentStep)
    }
    
    @ViewBuilder
    private func permissionStepView(
        icon: String,
        title: String,
        subtitle: String,
        footer: String,
        buttonTitle: String,
        action: @escaping () -> Void,
        secondaryAction: (() -> (any View))?
    ) -> some View {
        VStack(spacing: 24) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 160, height: 160)
                    .blur(radius: 20)
                
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.primaryBlue)
            }
            .padding(.bottom, 20)
            
            VStack(spacing: 16) {
                Text(title)
                    .font(.titleL)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text(subtitle)
                    .font(.bodyL)
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                if !footer.isEmpty {
                    Text(footer)
                        .font(.captionText)
                        .foregroundColor(.textTertiary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                }
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                PrimaryButton(title: buttonTitle, action: action)
                
                if let secondary = secondaryAction {
                    AnyView(secondary())
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .padding(.top, 60)
    }
}

struct PermissionsView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionsView(isPermissionsCompleted: .constant(false))
    }
}
