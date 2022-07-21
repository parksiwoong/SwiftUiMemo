//
//  MainListView.swift
//  SwiftUiMemo
//
//  Created by si woong park on 2022/07/20.
//

import SwiftUI

struct MainListView: View {
    @EnvironmentObject var store: MemoStore //뷰가 생성되는 시점에 공유 데이터를 확인하고 스토어속성과 동일한 타입이 등록돼 있다면 속성을 자동으로 초기화 해줌
    
    @State private var showComposer: Bool = false
    
    var body: some View {
        NavigationView {
            List(store.list){ memo in
                NavigationLink{  //NavigationLink 안에 넣으면 자동으로 링크가 생성됨 '>' 모양
                    DetailView(memo: memo)
                }label: {
                    MemoCell(memo: memo)
                }
               
            }
            .listStyle(.plain)
            .navigationTitle("내 메모")
            .toolbar{
                Button{
                    showComposer = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showComposer){
                ComposeView()
            }
        }
        
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
            .environmentObject(MemoStore())
    }
}
