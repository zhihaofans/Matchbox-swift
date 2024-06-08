//
//  ToolsView.swift
//  MacBox
//
//  Created by zzh on 2024/6/8.
//

import SwiftUI

struct ToolsView: View {
    @Binding var showPageId: String
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button(action: {
            /* self.loginService.checkWebLoginQrcode(qrcodeKey:self.qrcodeKey) { String in
             
             } fail: { String in
             
             }*/
            
            showPageId = "main"
        }) {
            Text("返回主页").font(.title)
        }
    }
}
