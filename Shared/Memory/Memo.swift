//
//  Memo.swift
//  SwiftUiMemo
//
//  Created by si woong park on 2022/07/20.
//

import Foundation
import SwiftUI

class Memo: Identifiable, ObservableObject{ // Identifiable 데이터를 리스트에 쉽게 바인딩하려고,
                                            // ObservableObject 메모를 편집, 뷰자동업데이트를 위해
    let id : UUID
    @Published var content: String // @Published 새로운값을 추가할때마다 바인딩돼 있는 ui가 자동으로 업데이트 됨
    let insertDate: Date
    
    init(content: String, insertDate: Date = Date.now){
        id = UUID()
        self.content = content
        self.insertDate = insertDate
    }
}
