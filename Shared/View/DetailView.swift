//
//  DetailView.swift
//  SwiftUiMemo
//
//  Created by si woong park on 2022/07/21.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var memo: MemoEntity
    @EnvironmentObject var manager: CoreDataManager
    @State private var showComposer = false // bool 속성 필요
    @State private var showDeleteAlert = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    HStack {
                        Text(memo.content ?? "")
                            .padding()
                        
                        Spacer(minLength: 0)
                    }
                    Text(memo.insertDate ?? .now, style: .date)
                        .padding()
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("메모 보기")
        .navigationBarTitleDisplayMode(.inline) //라지타이틀 모드는 사용하지 않을거니 인라인으로
        .toolbar{
            ToolbarItemGroup(placement: .bottomBar){
                Button{
                    showDeleteAlert = true
                }label: {
                    Image(systemName:  "trash")
                }
                .foregroundColor(.red)
                    .alert("삭제확인", isPresented: $showDeleteAlert){
                        Button(role: .destructive) {
                            manager.delete(memo: memo)
                            //dismiss()
                        } label: {
                            Text("삭제")
                        }
                    }message: {
                        Text("메모를 삭제할까요?")
                    }
                
                Button{
                    showComposer = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showComposer){
            ComposeView(memo:memo)
        } //편집이니 이니셜라이즈로 메모를 전달해야함
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(memo: MemoEntity(context:
                CoreDataManager.shared.mainContext))
                    .environmentObject(CoreDataManager.shared)
        }
       
    }
}
