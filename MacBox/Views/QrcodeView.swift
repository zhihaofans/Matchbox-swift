//
//  QrcodeView.swift
//  MacBox
//
//  Created by zzh on 2024/6/23.
//

import SwiftUI
import SwiftUtils

struct QrcodeView: View {
    @Binding var showPageId: String
    @State private var qrcodeStr = "Hello, Tools!"
    @State private var qrCodeImage: NSImage? = nil
    var body: some View {
        TextField("", text: $qrcodeStr).onChange(of: qrcodeStr) { _, _ in
            if qrcodeStr.isEmpty {
                qrcodeStr = "Hello, Tools!"
            }
            qrCodeImage = QrcodeUtil().generateQRCode(from: qrcodeStr)
        }
        if qrCodeImage != nil {
            Image(nsImage: qrCodeImage!)
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 200, height: 200)
        } else {
            Text("生成中...")
        }
    }

    func generateQRCode(from string: String) -> NSImage? {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                let size = NSSize(width: outputImage.extent.width, height: outputImage.extent.height)
                let nsImage = NSImage(cgImage: cgimg, size: size)
                return nsImage
            }
        }
        return nil
    }
}
