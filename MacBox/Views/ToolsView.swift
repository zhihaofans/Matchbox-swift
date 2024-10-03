//
//  ToolsView.swift
//  MacBox
//
//  Created by zzh on 2024/6/8.
//

import NaturalLanguage
import SwiftUI
import SwiftUtils

struct ToolsView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("工具", destination: ToolsOldView())
                NavigationLink(destination: Text("Detail View")) {
                    Text("工具")
                        .font(.largeTitle) // 设置字体大小
                }
                NavigationLink("二维码", destination: QrcodeView())
                NavigationLink("编码", destination: EncodeView())
                NavigationLink("文本分词", destination: FenciView())
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("工具")
            /* .toolbar {
                 ToolbarItem(placement: .automatic) {
                     NavigationLink(destination: MainView()) {
                         // TODO: 这里跳转到个人页面或登录界面
                         Image(systemName: "person")
                     }
                 }
             } */
        }
        .frame(minWidth: 800, minHeight: 600) // 设置窗口的最小尺寸
    }
}

struct ToolsOldView: View {
    @State private var showingAlert = false
    @State private var showingQrcodeAlert = false
    @State private var showingjsDelivrAlert = false
    @State private var githubUrl = "https://github.com/zhihaofans/macbox-swift/blob/main/MacBox/Views/ToolsView.swift"
    @State private var textStr = "Hello, Tools!"
    var body: some View {
        Text(textStr)

        Button(action: {
            // TODO:
        }) {
            Text("实况图片").font(.title)
        }
    }
}

struct FenciView: View {
    @State private var input = ""
    @State private var fenciList: [String] = []
    @State private var fenciUnit: NLTokenUnit = .document
    var body: some View {
        VStack {
            TextField("", text: $input).onChange(of: input) { _, _ in
                fenciList = FenciUtil(fenciUnit).fenci(input)
            }
            List(fenciList, id: \.self) {
                Text($0)
            }
        }
    }
}
