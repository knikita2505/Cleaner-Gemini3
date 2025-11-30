import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        ZStack {
            Color.backgroundMain.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Cleaner")
                        .font(.titleL)
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {}) {
                        Text("Start Free Trial")
                            .font(.captionText)
                            .fontWeight(.bold)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.statusSuccess)
                            .foregroundColor(.black)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 10)
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Storage Ring
                        StorageRingView(
                            totalStorage: viewModel.totalStorage,
                            usedStorage: viewModel.usedStorage,
                            cleanableStorage: viewModel.cleanableStorage
                        )
                        
                        // Categories Grid
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(viewModel.categories) { category in
                                CategoryCardView(
                                    title: category.title,
                                    subtitle: category.size,
                                    icon: category.icon,
                                    color: category.color,
                                    action: {
                                        // Navigate to category detail
                                    }
                                )
                                .frame(height: 140)
                            }
                        }
                    }
                    .padding(24)
                }
                
                // Tab Bar Placeholder (Visual only for now)
                HStack {
                    Spacer()
                    VStack(spacing: 4) {
                        Image(systemName: "square.grid.2x2.fill")
                        Text("Clean")
                            .font(.captionText)
                    }
                    .foregroundColor(.primaryBlue)
                    Spacer()
                }
                .padding(.top, 16)
                .background(Color.backgroundSecondary.ignoresSafeArea())
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
