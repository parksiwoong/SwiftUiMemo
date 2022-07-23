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
    let magager = CoreDataManager.shared

    var body: some Scene {
        WindowGroup {
            MainListView()
                .environment(\.managedObjectContext, magager.mainContext)
                .environmentObject(store)
        }
    }
}
