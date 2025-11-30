import SwiftUI

class DashboardViewModel: ObservableObject {
    @Published var totalStorage: Double = 128.0
    @Published var usedStorage: Double = 0.0
    @Published var cleanableStorage: Double = 0.0
    
    @Published var categories: [Category] = [
        Category(id: .duplicates, title: "Duplicates", icon: "photo.on.rectangle.angled", color: .primaryBlue),
        Category(id: .similar, title: "Similar Photos", icon: "photo.stack", color: .primaryPurple),
        Category(id: .screenshots, title: "Screenshots", icon: "camera.viewfinder", color: .lightPurple),
        Category(id: .videos, title: "Videos", icon: "video.fill", color: .glowBlue),
        Category(id: .contacts, title: "Contacts", icon: "person.2.fill", color: .statusWarning),
        Category(id: .calendar, title: "Calendar", icon: "calendar", color: .statusSuccess)
    ]
    
    struct Category: Identifiable {
        let id: CategoryType
        let title: String
        let icon: String
        let color: Color
        var size: String = "Scanning..."
        var sizeValue: Double = 0.0
    }
    
    enum CategoryType {
        case duplicates, similar, screenshots, videos, contacts, calendar
    }
    
    init() {
        scanStorage()
    }
    
    func scanStorage() {
        // Simulate scanning
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation {
                self.usedStorage = 95.0
                self.cleanableStorage = 12.5
                
                self.updateCategory(type: .duplicates, size: "1.2 GB", value: 1.2)
                self.updateCategory(type: .similar, size: "850 MB", value: 0.85)
                self.updateCategory(type: .screenshots, size: "450 MB", value: 0.45)
                self.updateCategory(type: .videos, size: "5.4 GB", value: 5.4)
                self.updateCategory(type: .contacts, size: "150 contacts", value: 0.0)
                self.updateCategory(type: .calendar, size: "Clean", value: 0.0)
            }
        }
    }
    
    private func updateCategory(type: CategoryType, size: String, value: Double) {
        if let index = categories.firstIndex(where: { $0.id == type }) {
            categories[index].size = size
            categories[index].sizeValue = value
        }
    }
}
