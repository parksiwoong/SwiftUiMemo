//
//  DetailView.swift
//  SwiftUiMemo
//
//  Created by si woong park on 2022/07/21.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var memo: Memo
    @EnvironmentObject var store: MemoStore
    
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    HStack {
                        Text(memo.content)
                            .padding()
                        
                        Spacer(minLength: 0)
                    }
                    Text(memo.insertDate, style: .date)
                        .padding()
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("내 메모")
        .navigationBarTitleDisplayMode(.inline) //라지타이틀 모드는 사용하지 않을거니 인라인으로
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(memo: Memo(content: "Hello"))
            .environmentObject(MemoStore())
    }
}
