//
//  MemoCell.swift
//  SwiftUiMemo
//
//  Created by si woong park on 2022/07/20.
//

import SwiftUI


struct MemoCell: View {
    @ObservedObject var memo: Memo //@ObservedObject 메모가 업데이트 되는시점마다 뷰가 새롭게 업데이트 되고 최신데이터를 표시가능
    var body: some View {
        VStack(alignment: .leading) {
            Text(memo.content)
                .font(.body)
                .lineLimit(1)
            Text(memo.insertDate, style: .date)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}



struct MemoCell_Previews: PreviewProvider {
    static var previews: some View {
        MemoCell(memo: Memo(content: "Test"))
    }
}
