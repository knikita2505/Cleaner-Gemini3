import SwiftUI

struct PaywallView: View {
    @StateObject private var viewModel: PaywallViewModel
    
    init(isPaywallCompleted: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: PaywallViewModel(isPaywallCompleted: isPaywallCompleted))
    }
    
    var body: some View {
        ZStack {
            Color.auroraGradient.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Spacer()
                    Button(action: viewModel.skip) {
                        Text("Skip")
                            .font(.bodyM)
                            .foregroundColor(.white.opacity(0.6))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Icon & Title
                        VStack(spacing: 16) {
                            Image(systemName: "sparkles.rectangle.stack.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 64, height: 64)
                                .foregroundColor(.white)
                            
                            Text("Clean up your iPhone\nfast & easy")
                                .font(.titleL)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 20)
                        
                        // Benefits
                        VStack(alignment: .leading, spacing: 12) {
                            benefitRow(icon: "photo.on.rectangle", text: "Delete duplicates")
                            benefitRow(icon: "video", text: "Compress videos")
                            benefitRow(icon: "lock.fill", text: "Secret album")
                            benefitRow(icon: "battery.100", text: "Battery tips")
                        }
                        .padding(.vertical, 20)
                        
                        // Trial Toggle
                        HStack {
                            Text("Free Trial Enabled")
                                .font(.subtitleM)
                                .foregroundColor(.white)
                            Spacer()
                            Toggle("", isOn: $viewModel.isTrialEnabled)
                                .labelsHidden()
                                .tint(.statusSuccess)
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(16)
                        
                        if viewModel.isTrialEnabled {
                            Text("7 days free, then $6.99/week")
                                .font(.captionText)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        // Plans
                        VStack(spacing: 12) {
                            planRow(plan: .yearly, title: "Yearly Plan", price: "$34.99/year", badge: "Most Popular")
                            planRow(plan: .weekly, title: "Weekly Plan", price: "$6.99/week", badge: nil)
                        }
                    }
                    .padding(24)
                }
                
                // Footer
                VStack(spacing: 16) {
                    PrimaryButton(title: viewModel.buttonTitle, action: viewModel.purchase)
                    
                    Text("Terms of Service • Privacy Policy")
                        .font(.captionText)
                        .foregroundColor(.white.opacity(0.4))
                }
                .padding(24)
                .background(Color.backgroundMain.opacity(0.8))
            }
        }
    }
    
    @ViewBuilder
    private func benefitRow(icon: String, text: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.primaryBlue)
                .frame(width: 24)
            Text(text)
                .font(.bodyL)
                .foregroundColor(.white)
        }
    }
    
    @ViewBuilder
    private func planRow(plan: PaywallViewModel.Plan, title: String, price: String, badge: String?) -> some View {
        Button(action: { viewModel.selectedPlan = plan }) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(title)
                            .font(.subtitleM)
                            .foregroundColor(.white)
                        if let badge = badge {
                            Text(badge)
                                .font(.captionText)
                                .fontWeight(.bold)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.primaryPurple)
                                .cornerRadius(8)
                                .foregroundColor(.white)
                        }
                    }
                    Text(price)
                        .font(.bodyM)
                        .foregroundColor(.white.opacity(0.7))
                }
                Spacer()
                Circle()
                    .stroke(Color.white.opacity(0.5), lineWidth: 2)
                    .frame(width: 24, height: 24)
                    .overlay(
                        Circle()
                            .fill(viewModel.selectedPlan == plan ? Color.primaryBlue : Color.clear)
                            .padding(4)
                    )
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(viewModel.selectedPlan == plan ? Color.primaryBlue : Color.white.opacity(0.1), lineWidth: 2)
                    .background(Color.white.opacity(0.05))
            )
        }
    }
}

struct PaywallView_Previews: PreviewProvider {
    static var previews: some View {
        PaywallView(isPaywallCompleted: .constant(false))
    }
}
