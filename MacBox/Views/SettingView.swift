//
//  SettingView.swift
//  MacBox
//
//  Created by zzh on 2024/10/2.
//

import SwiftUI
import SwiftUtils

struct SettingView: View {
    private let udUtil = UserDefaultUtil()
    var body: some View {
        VStack {
            List {
                if let appIcon = AppUtil().getAppIconImage() {
                    AppIconAndNameView(image: appIcon)
                } else {
                    Text("加载应用图标失败：可能未设置")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                Section(header: Text("关于")) {
                    SimpleTextItemView(title: "开发者", detail: "zhihaofans")
                    SimpleTextItemView(title: "版本号", detail: "\(AppUtil().getAppVersion()) (\(AppUtil().getAppBuild()))" /* "0.0.1" */ )
//                    NavigationLink(destination: FeatureView()) {
//                        SimpleTextItemView(title: "功能更新", detail: "点击看更新到哪了")
//                    }
                }
            }
        }
    }
}

struct AppIconAndNameView: View {
    #if os(macOS)
    let image: NSImage
    #else
    let image: UIImage
    #endif
    var body: some View {
        VStack(alignment: .center) {
            // Text(s)
            #if os(macOS)
            Image(nsImage: image)
                .resizable() // 允许图片可调整大小
                .scaledToFit() // 图片将等比缩放以适应框架
                .frame(width: 120, height: 120) // 设置视图框架的大小
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous)) // 设置圆角矩形形状
                .shadow(radius: 5) // 添加阴影以增强效果
            #else
            Image(uiImage: image)
                .resizable() // 允许图片可调整大小
                .scaledToFit() // 图片将等比缩放以适应框架
                .frame(width: 120, height: 120) // 设置视图框架的大小
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous)) // 设置圆角矩形形状
                .shadow(radius: 5) // 添加阴影以增强效果
            #endif

            // .overlay(Circle().stroke(Color.gray, lineWidth: 4)) // 可选的白色边框
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 100, height: 100)
            Text(AppUtil().getAppName())
                .font(.largeTitle)
                .padding()
        }
        .frame(maxWidth: .infinity, alignment: .center) // 设置对齐方式
    }
}

#Preview {
    SettingView()
}
