//
//  ContentView.swift
//  MacBox
//
//  Created by zzh on 2024/5/29.
//

import SwiftUI
import Alamofire
import CoreImage.CIFilterBuiltins
struct ContentView: View {
     private  let pageTitleList = ["main": "主页", "tool":  "工具"]
    @State private var showPageId = "main"
    @State  private var showPageTitle = "主页"
    var body: some View {
        VStack {
            switch showPageId.lowercased(){
                
            case "main":
                MainView(showPageId: $showPageId)
                
            case "tool":
                ToolsView(showPageId: $showPageId)
            default:
                
                Text("错误导航")
                    .font(.largeTitle)
                    .padding()
            }
            
        }
        .onChange(of: showPageId) {
            // 当 a 改变时，更新 b
            showPageTitle = getPageTitle()
        }
        .onAppear {
            
            //self.getQrcodeData()
        }.navigationTitle(showPageTitle)
            .padding()
    }
    private func getPageTitle() -> String{
        return pageTitleList[showPageId] ?? "未知导航"
    }
}

#Preview {
    ContentView()
}
