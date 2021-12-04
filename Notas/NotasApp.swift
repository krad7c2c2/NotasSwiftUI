//
//  NotasApp.swift
//  Notas
//
//  Created by Jorge Maldonado Borbón on 21/12/20.
//

import SwiftUI

@main
struct NotasApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
