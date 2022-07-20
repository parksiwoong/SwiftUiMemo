//
//  MemoStore.swift
//  SwiftUiMemo
//
//  Created by si woong park on 2022/07/20.
//

import Foundation       // 메모목록 저장하는 클래스 구현

class MemoStore: ObservableObject{
    @Published var list: [Memo] //@Published 앞에 적으면 배열을 업데이트할때마다 바인딩 돼 있는 뷰도 자동으로 업뎃
    
    init(){
        list = [
            Memo(content: "Hello", insertDate: Date.now)
            ,Memo(content: "Awesome", insertDate: Date.now.addingTimeInterval(3600 * -24))
            ,Memo(content: "SwiftUI", insertDate: Date.now.addingTimeInterval(3600 * -48))
        ]
    }
    
    //crud
    //추가
    func insert(memo: String){
        list.insert(Memo(content: memo), at: 0) // 새로운메모는 0번 인덱스에 넣기 위해서 at: 0
    }
    
    //수정
    func update(memo: Memo? , content: String){
        guard let memo = memo else{
            return
        }
        memo.content = content
    }
    
    //삭제
    func delete(memo: Memo) {
        list.removeAll {$0.id == memo.id}
    }
    func delete(set: IndexSet){  //forin문에서 반복하면서 배열을 삭제 하려고 만든거
        for index in set {
            list.remove(at: index)
        }
    }
}
