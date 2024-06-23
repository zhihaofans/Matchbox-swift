//
//  MainView.swift
//  MacBox
//
//  Created by zzh on 2024/6/9.
//

import SwiftUI

struct MainView: View {
    @Binding var showPageId: String
    var body: some View {
        Text("Hello, MacBox!")
        Button(action: {
            showPageId = "tool"
        }) {
            Text("工具箱").font(.title)
        }
        Button(action: {
            showPageId = "reminder"
        }) {
            Text("提醒事项").font(.title)
        }
        Button(action: {
            showPageId = "encode"
        }) {
            Text("编码加密").font(.title)
        }
        Button(action: {
            showPageId = "keychain"
        }) {
            Text("KeyChain").font(.title)
        }
        Button(action: {
            showPageId = "downloader"
        }) {
            Text("下载器").font(.title)
        }
    }
}
