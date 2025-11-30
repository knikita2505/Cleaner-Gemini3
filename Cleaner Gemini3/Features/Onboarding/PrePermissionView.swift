import SwiftUI

struct PrePermissionView: View {
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // Icon
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 160, height: 160)
                    .blur(radius: 20)
                
                Image(systemName: "photo.on.rectangle.angled")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
            }
            .padding(.bottom, 20)
            
            VStack(spacing: 16) {
                Text("To start cleaning, allow access to your photos")
                    .font(.titleL)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text("We use access only to find duplicates and unnecessary files. Everything stays on your device.")
                    .font(.bodyL)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                Text("You can change this later in settings.")
                    .font(.captionText)
                    .foregroundColor(.white.opacity(0.5))
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                PrimaryButton(title: "Enable Photo Access", action: action)
                
                Button(action: action) {
                    Text("Skip for now")
                        .font(.bodyM)
                        .foregroundColor(.white.opacity(0.6))
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .padding(.top, 60)
    }
}

struct PrePermissionView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.auroraGradient.ignoresSafeArea()
            PrePermissionView(action: {})
        }
    }
}
