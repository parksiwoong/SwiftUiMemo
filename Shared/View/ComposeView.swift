//
//  ComposeView.swift
//  SwiftUiMemo
//
//  Created by si woong park on 2022/07/20.
//

import SwiftUI

struct ComposeView: View {
    @EnvironmentObject var store: MemoStore
    
    var memo: Memo? = nil //여기에 전달되면 편집모드 전달되지않으면 쓰기모드
    
    @Environment(\.dismiss) var dismiss //화면을 닫을때 쓰는 액션
    
    @State private var content: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Text("Hello, World!") 보는거만되고 입력이 안되서 이건 지움
                TextEditor(text: $content) //이렇게 하면 콘텍트속성와 텍스트에디터가 바인딩되고 입력한 내용이 콘텍트 속성에 자동으로 저장됨 , 이런방식이 투에이바인딩
                    .padding() //기본여백추가
                    .onAppear{ //화면이 표시되는 시점에 화면을 초기화 구현 하고싶다면 여기서 구현하면 됨
                        if let memo = memo {
                            content = memo.content
                        }//메모가 전달 되었다면 편집할 내용을 전달할거
                        
                    }
            }
            .navigationTitle(memo != nil ? "메모편집" : "새 메모")
            .navigationBarTitleDisplayMode(
                .inline)
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarLeading){ //navigationBarLeading 왼쪽이란뜻
                    Button{
                        if let memo = memo {
                            store.update(memo: memo, content: content)
                        }else{
                            store.insert(memo: content)
                        }
                        dismiss()
                    } label: {
                        Text("취소") //버튼의 타이틀 리턴
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing){ //navigationBarTrailing 오른쪽이란말
                    Button{
                        store.insert(memo: content)
                        dismiss()
                    } label: {
                        Text("저장") //버튼의 타이틀 리턴
                    }
                }
            } //네비게이션을 저장하려면 툴바 쓰면됨
        }
    }
}

struct ComposeView_Previews: PreviewProvider {
    static var previews: some View {
        ComposeView()
            .environmentObject(MemoStore())
    }
}
