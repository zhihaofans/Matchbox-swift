//
//  ToolsView.swift
//  MacBox
//
//  Created by zzh on 2024/6/8.
//

import SwiftUI

struct ToolsView: View {
    @Binding var showPageId: String
    @State var newPageId = ""
    @State private var showingAlert = false
    var body: some View {
        Text("Hello, Tools!")
        Button(action: {
            showPageId = "main"
        }) {
            Text("返回主页").font(.title)
        }
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
    }
}
