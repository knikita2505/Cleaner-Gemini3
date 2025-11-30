import SwiftUI

struct CategoryCardView: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    ZStack {
                        Circle()
                            .fill(color.opacity(0.2))
                            .frame(width: 40, height: 40)
                        
                        Image(systemName: icon)
                            .foregroundColor(color)
                            .font(.system(size: 20))
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.textTertiary)
                        .font(.system(size: 14))
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.subtitleM)
                        .foregroundColor(.white)
                    
                    Text(subtitle)
                        .font(.bodyM)
                        .foregroundColor(.textTertiary)
                }
            }
            .padding(16)
            .background(Color.backgroundSecondary)
            .cornerRadius(20)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.backgroundMain.ignoresSafeArea()
            CategoryCardView(
                title: "Duplicates",
                subtitle: "1.2 GB",
                icon: "photo.on.rectangle.angled",
                color: .primaryBlue,
                action: {}
            )
            .frame(width: 160, height: 140)
        }
    }
}
