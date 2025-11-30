import SwiftUI

struct StorageRingView: View {
    let totalStorage: Double // in GB
    let usedStorage: Double // in GB
    let cleanableStorage: Double // in GB
    
    private var progress: Double {
        guard totalStorage > 0 else { return 0 }
        return usedStorage / totalStorage
    }
    
    private var cleanableProgress: Double {
        guard totalStorage > 0 else { return 0 }
        return cleanableStorage / totalStorage
    }
    
    var body: some View {
        ZStack {
            // Background Circle
            Circle()
                .stroke(Color.white.opacity(0.1), lineWidth: 20)
            
            // Used Storage Arc
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.primaryBlue,
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            
            // Cleanable Storage Arc (overlay)
            Circle()
                .trim(from: progress - cleanableProgress, to: progress)
                .stroke(
                    Color.statusWarning,
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            
            // Center Text
            VStack(spacing: 4) {
                Text("Space to clean")
                    .font(.captionText)
                    .foregroundColor(.textTertiary)
                
                Text(String(format: "%.1f GB", cleanableStorage))
                    .font(.titleL)
                    .foregroundColor(.white)
                
                Text("\(Int(cleanableProgress * 100))% of usage")
                    .font(.captionText)
                    .foregroundColor(.statusWarning)
            }
        }
        .frame(height: 220)
        .padding()
    }
}

struct StorageRingView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.backgroundMain.ignoresSafeArea()
            StorageRingView(totalStorage: 128, usedStorage: 90, cleanableStorage: 12.5)
        }
    }
}
