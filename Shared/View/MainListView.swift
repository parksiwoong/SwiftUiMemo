//
//  MainListView.swift
//  SwiftUiMemo
//
//  Created by si woong park on 2022/07/20.
//

import SwiftUI

struct MainListView: View {
    @EnvironmentObject var manager: CoreDataManager //뷰가 생성되는 시점에 공유 데이터를 확인하고 스토어속성과 동일한 타입이 등록돼 있다면 속성을 자동으로 초기화 해줌
    
    @State private var showComposer: Bool = false
    
    //초기화시점에 데이터를 읽어오는 속성에 자동으로 저장하는 코드    @FetchRequest 이 특성은 하지만 뷰 안에서만 사용해야함 뷰밖에서 사용하면 제대로 동작하지않음
    @FetchRequest(sortDescriptors: [SortDescriptor(\MemoEntity.insertDate, order: .reverse)])
    var memoList: FetchedResults<MemoEntity>
    
    @State private var keyword = ""
    @State private var sortByDateDesc = true //트루가 되면 내림차순 할생각
    
    var body: some View {
        NavigationView {
            List{
                ForEach(memoList){ memo in
                    NavigationLink{  //NavigationLink 안에 넣으면 자동으로 링크가 생성됨 '>' 모양
                        DetailView(memo: memo)
                    }label: {
                        MemoCell(memo: memo)
                    }
                }
                .onDelete(perform: delete)
            }
            .listStyle(.plain)
            .navigationTitle("내 메모")
            .toolbar{
                HStack {
                    Button{
                        showComposer = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    Button{
                        sortByDateDesc.toggle()
                    }label: {
                        Image(systemName: "arrow.up.arrow.down") //화살표이미지
                    }
                }
            }
            .sheet(isPresented: $showComposer){
                ComposeView()
            }
            //검색기능 추가
            .searchable(text: $keyword, prompt: "내용을 검색합니다.")
            .onChange(of: keyword){ newValue in
                       if keyword.isEmpty{
                           memoList.nsPredicate = nil
                       }else {
                           memoList.nsPredicate = NSPredicate(format:
                                "content CONTAINS[c] %@" , newValue)
                       }
            }
            .onChange(of: sortByDateDesc){desc in
                if desc {
                    memoList.sortDescriptors = [
                        SortDescriptor(\.insertDate, order: .reverse)
                    ]
                } else{
                    memoList.sortDescriptors = [
                        SortDescriptor(\.insertDate,order: .forward)
                    ]
                }
            }
        }
        
    }
    
    func delete(set: IndexSet){
        for index in set{
            manager.delete(memo: memoList[index])
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
            .environmentObject(CoreDataManager.shared)
    }
}

