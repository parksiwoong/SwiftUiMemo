//
//  SwiftUiMemoApp.swift
//  Shared
//
//  Created by si woong park on 2022/07/20.
//

import SwiftUI

@main
struct SwiftUiMemoApp: App {
    @StateObject var store = MemoStore() // 메모저장소에서 모두 사용할 수 있도록
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(store)
        }
    }
}
