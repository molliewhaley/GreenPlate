//
//  GreenPlateAppApp.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/16/23.
//

import SwiftUI

@main
struct GreenPlateAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
