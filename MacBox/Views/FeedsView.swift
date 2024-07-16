//
//  FeedsView.swift
//  MacBox
//
//  Created by zzh on 2024/7/12.
//

import SwiftUI

struct FeedsView: View {
    @State var isError=false
    @State var errStr="Hello, World!"
    @State var feedsList: [FeedsItem]=[]
    var body: some View {
        ScrollView {
            LazyVStack {
                if isError {
                    Text(errStr).font(.largeTitle)
                } else {
                    ForEach(feedsList, id: \.id) { item in
                        FeedsItemView(itemData: item)
                    }
                }
            }.onAppear {
                // TODO: 加载Feeds数据
                FeedsService().getWeiboHot { data in
                    if data.isEmpty {
                        isError=true
                        errStr="空白结果列表"
                    } else {
                        feedsList=data
                        isError=false
                    }
                } fail: { err in
                    isError=true
                    errStr=err
                }
            }
        }
    }
}

struct FeedsItemView: View {
    var itemData: FeedsItem
    var body: some View {
        VStack {
            HSplitView {
                AsyncImage(url: URL(string: itemData.cover)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 84)
                VStack {
                    Text(itemData.title).font(.largeTitle)
                    Text(itemData.author)
                }
                // .frame(width: geometry.size.width)
            }
        }
        .frame(height: 100) // 将 VStack 的固定高度设置为100
        .contentShape(Rectangle()) // 加这行才实现可点击
        .onTapGesture {
            // TODO: onClick
        }
    }
}
