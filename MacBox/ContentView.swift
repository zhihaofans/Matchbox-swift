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
    @State private var qrCodeImage: NSImage? = nil
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    private var loginService = LoginService()
    @State private var buttonText="我已扫码"
    @State private var qrcodeKey=""
    var body: some View {
        VStack {
            
            Text("打开哔哩哔哩扫描二维码登录")
                .font(.largeTitle)
                .padding()
            /*
             // 使用 AsyncImage 加载在线图片
             AsyncImage(url: URL(string:imageUrl)) { image in
             image
             .resizable()
             .aspectRatio(contentMode: .fit)
             } placeholder: {
             Text("loading...")
             ProgressView() // 加载中的占位图
             }
             .frame(width: 300, height: 300)
             .clipShape(RoundedRectangle(cornerRadius: 15))*/
            if let qrCodeImage = qrCodeImage {
                Image(nsImage:  qrCodeImage)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } else {
                Text("生成中...")
            }
            Button(action: {
                buttonText = "未登陆🙅"
                self.loginService.checkWebLoginQrcode(qrcodeKey:self.qrcodeKey) { String in
                    
                } fail: { <#String#> in
                    <#code#>
                }

            }) {
                Text(buttonText).font(.title)
            }
        }
        .onAppear {
            self.loginService.getWebLoginQrcode { qrcode_key in
                if !qrcode_key.isEmpty{
                    qrcodeKey=qrcode_key
                    generateQRCode(from: "https://passport.bilibili.com/h5-app/passport/login/scan?navhide=1&from=&qrcode_key="+qrcodeKey)
                }else{
                    
                    buttonText = "空白二维码"
                }
            } fail: { errorMsg in
                buttonText = "错误"+errorMsg
            }
            
            //self.getQrcodeData()
        }
        .padding()
    }
    
    private func generateQRCode(from string: String) {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                let size = NSSize(width: outputImage.extent.width, height: outputImage.extent.height)
                let nsImage = NSImage(cgImage: cgimg, size: size)
                self.qrCodeImage = nsImage
            }
        }
    }
}

#Preview {
    ContentView()
}
