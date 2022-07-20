//
//  ComposeView.swift
//  SwiftUiMemo
//
//  Created by si woong park on 2022/07/20.
//

import SwiftUI

struct ComposeView: View {
    @EnvironmentObject var store: MemoStore
    @Environment(\.dismiss) var dismiss //화면을 닫을때 쓰는 액션
    
    @State private var content: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
               // Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/) 보는거만되고 입력이 안되서 이건 지움
                TextEditor(text: $content) //이렇게 하면 콘텍트속성와 텍스트에디터가 바인딩되고 입력한 내용이 콘텍트 속성에 자동으로 저장됨 , 이런방식이 투에이바인딩
                    .padding() //기본여백추가
            }
            .navigationTitle("새 메모")
            .navigationBarTitleDisplayMode(
                .inline)
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarLeading){ //navigationBarLeading 왼쪽이란뜻
                            Button{
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
