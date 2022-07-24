//
//  CoreDataManager.swift
//  SwiftUiMemo
//
//  Created by si woong park on 2022/07/23.
//  코어데이터를 사용해서 list를 안쓰고 영구적으로 데이터가 유지되도록 하는 목적의 파일

import Foundation
import CoreData
import SwiftUI

class CoreDataManager: ObservableObject {
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer

    var mainContext: NSManagedObjectContext{ //콘텍스트접근할때는 항상 이속성에서 접근할꺼
        return container.viewContext
    }
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SwiftUiMemo")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func savecontext() {   //이제 컨텍스트를 저장해야하는데 자주쓰니깐 별도로 빼서 사용
        if mainContext.hasChanges{
            do{
                try mainContext.save()
            }catch {
                print(error)
            }
        }
    }
    
    func addMemo(content: String){ //새로운 메모를 추가하는 코드 구현
        let newMemo = MemoEntity(context: mainContext)
        newMemo.content = content
        newMemo.insertDate = Date.now
        
    }
    
    //업데이트 메소드 구현
    func update(memo: MemoEntity? ,  content: String){
        memo?.content = content
        savecontext()
    }
    
    //삭제 메소드 구현
    func delete(memo: MemoEntity?){
        if let memo = memo{
            mainContext.delete(memo)
            savecontext()
        }
    }
}
