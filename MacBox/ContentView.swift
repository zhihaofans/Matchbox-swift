//
//  ContentView.swift
//  MacBox
//
//  Created by zzh on 2024/5/29.
//

import Alamofire
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    private let pageTitleList = ["main": "MacBox", "tool": "工具", "reminder": "提醒事项"]
    @State private var showPageId = "main"
    @State private var showPageTitle = "主页"
    var body: some View {
        VStack {
            switch showPageId.lowercased() {
            case "main":
                MainView(showPageId: $showPageId)

            case "tool":
                ToolsView(showPageId: $showPageId)

            case "reminder":
                ReminderView(showPageId: $showPageId).modelContainer(for: ReminderItemModel.self)

            default:

                Text("错误导航")
                    .font(.largeTitle)
                    .padding()
                Button(action: {
                    showPageId = "main"
                }) {
                    Text("返回主页").font(.title)
                }
            }
        }
        .onChange(of: showPageId) {
            // 当 a 改变时，更新 b
            showPageTitle = getPageTitle()
        }
        .onAppear {
            // self.getQrcodeData()
        }.navigationTitle(showPageTitle)
        .padding()
    }

    private func getPageTitle() -> String {
        return pageTitleList[showPageId] ?? "未知导航"
    }
}

#Preview {
    ContentView()
}
