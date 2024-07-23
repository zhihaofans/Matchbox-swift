//
//  QrcodeView.swift
//  MacBox
//
//  Created by zzh on 2024/6/23.
//

import SwiftUI
import SwiftUtils

struct QrcodeView: View {
    @State private var qrcodeStr = "Hello, Tools!"
    @State private var qrCodeImage: NSImage? = nil
    var body: some View {
        VStack {
            TextField("", text: $qrcodeStr).onChange(of: qrcodeStr) { _, _ in
                if qrcodeStr.isEmpty {
                    qrCodeImage = QrcodeUtil().generateQRCode(from: "Hello, Tools!")
                } else {
                    qrCodeImage = QrcodeUtil().generateQRCode(from: qrcodeStr)
                }
            }
            if qrCodeImage != nil {
                Image(nsImage: qrCodeImage!)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contentShape(Rectangle()) // 加这行才实现可点击
                    .onTapGesture {
                        // TODO: onClick
                    }
            } else {
                Text("生成中...")
            }
        }.onAppear {
            qrCodeImage = QrcodeUtil().generateQRCode(from: qrcodeStr)
        }
    }
}
