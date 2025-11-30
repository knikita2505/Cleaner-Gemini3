//
//  Cleaner_Gemini3App.swift
//  Cleaner Gemini3
//
//  Created by Nikita on 30.11.2025.
//

import SwiftUI

@main
struct Cleaner_Gemini3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
