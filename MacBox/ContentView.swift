//
//  ContentView.swift
//  MacBox
//
//  Created by zzh on 2024/5/29.
//

import Alamofire
import CoreImage.CIFilterBuiltins
import SwiftUI

class CustomWindowController: NSWindowController {
    convenience init(rootView: NSView) {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 400, height: 300), // 定义窗口大小
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        window.center() // 窗口居中
        self.init(window: window)
        window.contentView = rootView
        window.makeKeyAndOrderFront(nil)
    }
}

struct ContentView: View {
    private let pageTitleList = ["main": "MacBox", "tool": "工具", "reminder": "提醒事项", "encode": "编码加密", "qrcode": "二维码", "setting": "设置"]
    @State private var showPageId = "main"
    @State private var showPageTitle = "主页"
    private let rootView = NSHostingController(rootView: SettingView())
    var body: some View {
        VStack {
            switch showPageId.lowercased() {
            case "main":
                MainView(showPageId: $showPageId)

            case "tool":
                ToolsView()

            case "keychain":
                KeychainView()

            case "feeds":
                FeedsView()

            case "reminder":
                ReminderView().modelContainer(for: ReminderItemModel.self)

            case "setting":
                SettingView()

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
        }.toolbar {
            // 增加数据
            Button("Home", systemImage: "house", action: {
                showPageId = "main"
            })
            Button("Setting", systemImage: "gear", action: {
                showPageId = "setting"

//                let windowController = CustomWindowController(rootView: rootView.view)
//                windowController.showWindow(nil)
//                NSApp.activate(ignoringOtherApps: true)

            })
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
        return pageTitleList[showPageId] ?? showPageId.uppercased()
    }
}

#Preview {
    ContentView()
}
