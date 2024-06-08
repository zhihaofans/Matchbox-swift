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
        Text("Hello, World!")
        
        Button(action: {
            showPageId = "tool"
        }) {
            Text("打开工具").font(.title)
        }
    }
}
