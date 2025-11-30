import SwiftUI
import Photos

class PermissionsViewModel: ObservableObject {
    @Published var currentStep: PermissionStep = .photos
    @Binding var isPermissionsCompleted: Bool
    
    enum PermissionStep {
        case photos
        case notifications
    }
    
    private let photoService = PhotoLibraryService.shared
    private let notificationService = NotificationService.shared
    
    init(isPermissionsCompleted: Binding<Bool>) {
        self._isPermissionsCompleted = isPermissionsCompleted
    }
    
    func requestPhotosPermission() async {
        let status = await photoService.requestAuthorization()
        await MainActor.run {
            if status == .authorized || status == .limited {
                nextStep()
            } else {
                // Handle denied state (optional: show alert or guide to settings)
                nextStep() // Proceed anyway for now
            }
        }
    }
    
    func requestNotificationPermission() async {
        _ = await notificationService.requestAuthorization()
        await MainActor.run {
            completePermissions()
        }
    }
    
    func skipNotifications() {
        completePermissions()
    }
    
    private func nextStep() {
        withAnimation {
            currentStep = .notifications
        }
    }
    
    private func completePermissions() {
        withAnimation {
            isPermissionsCompleted = true
        }
    }
}
