import SwiftUI

extension Color {
    // MARK: - Backgrounds
    static let backgroundMain = Color(hex: "0D0F16")
    static let backgroundSecondary = Color(hex: "111214")
    static let backgroundTertiary = Color(hex: "121317")
    
    // MARK: - Accents
    static let primaryBlue = Color(hex: "3B5BFF")
    static let primaryPurple = Color(hex: "7A4DFB")
    static let lightPurple = Color(hex: "A88CFF")
    static let glowBlue = Color(hex: "7FB9FF")
    
    // MARK: - Text
    static let textMain = Color.white
    static let textSecondary = Color(hex: "E6E8ED")
    static let textTertiary = Color(hex: "AEB4BE")
    
    // MARK: - Status
    static let statusSuccess = Color(hex: "41D3B3")
    static let statusWarning = Color(hex: "FFB84D")
    static let statusError = Color(hex: "FF4D4D")
    
    // MARK: - Gradients
    static let ctaGradient = LinearGradient(
        colors: [Color.primaryBlue, Color.primaryPurple],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    static let auroraGradient = LinearGradient(
        colors: [
            Color(hex: "2F3DAF"),
            Color(hex: "6B3BDB"),
            Color(hex: "8B5CFF")
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let activeBarGradient = LinearGradient(
        colors: [Color(hex: "FF8D4D"), Color(hex: "FFD36B")],
        startPoint: .leading,
        endPoint: .trailing
    )
}

// MARK: - Hex Support
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
