//
//  SwiftUiMemoApp.swift
//  Shared
//
//  Created by si woong park on 2022/07/20.
//

import SwiftUI

@main
struct SwiftUiMemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
