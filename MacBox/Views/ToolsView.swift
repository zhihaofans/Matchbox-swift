//
//  ToolsView.swift
//  MacBox
//
//  Created by zzh on 2024/6/8.
//

import SwiftUI
import SwiftUtils

struct ToolsView: View {
    @Binding var showPageId: String
    @State var newPageId = ""
    @State private var showingAlert = false
    @State private var showingQrcodeAlert = false
    @State private var showingjsDelivrAlert = false
    @State private var githubUrl = "https://github.com/zhihaofans/macbox-swift/blob/main/MacBox/Views/ToolsView.swift"
    @State private var textStr = "Hello, Tools!"
    var body: some View {
        Text(textStr)
        Button(action: {
            showingAlert = true
        }) {
            Text("跳转页面").font(.title)
        }
        .alert("输入页面id", isPresented: $showingAlert) {
            TextField("ID:", text: $newPageId)
            Button("OK", action: {
                print(newPageId)
                if newPageId.isNotEmpty {
                    print(showPageId)
                    showPageId = newPageId
                }
            })
        } message: {
            Text("MacBox会很智能的跳转，除非你乱输入id")
        }
        Button(action: {
            showPageId = "qrcode"
        }) {
            Text("二维码").font(.title)
        }
        Button(action: {
            showPageId = "livephotoeditor"
        }) {
            Text("实况图片").font(.title)
        }
    }
}
