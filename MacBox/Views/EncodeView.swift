//
//  EncodeView.swift
//  MacBox
//
//  Created by zzh on 2024/6/19.
//

import SwiftUI
import SwiftUtils

struct EncodeView: View {
    @State private var encodeMode = "urlencode"
    @State private var encodeStr = ""
    @State private var selectedFlavor = ""
    @State private var encodeResult = ""
    @State private var showingAlert = false
    @State private var alertTitle = "错误"
    @State private var alertText = "未知错误"
    var body: some View {
        VStack {
            Picker("模式", selection: $encodeMode) {
                Text("Url编码").tag("urlencode")
                Text("Url解码").tag("urldecode")
                Text("Base64编码").tag("base64encode")
                Text("Base64解码").tag("base64decode")
                Text("Sha256加密").tag("sha256")
                Text("Sha384加密").tag("sha384")
                Text("Sha512加密").tag("sha512")
                Text("Github转jsDelivr").tag("github2jsdelivr")
            }
            TextField("请输入:", text: $encodeStr)
            TextField("结果:", text: $encodeResult)
            Button(action: {
                self.auto()
            }) {
                Text("Go").font(.title)
            }
        }
        .alert("结果", isPresented: $showingAlert) {
            Button("OK", action: {
                alertText = ""
            })
        } message: {
            Text(alertText)
        }
    }

    private func auto() {
        if encodeStr.isNotEmpty {
            switch encodeMode.lowercased() {
            case "urlencode":
                encodeResult = EncodeUtil().urlEncode(encodeStr)
            case "urldecode":
                encodeResult = EncodeUtil().urlDecode(encodeStr)
            case "base64encode":
                encodeResult = EncodeUtil().base64Encode(encodeStr)
            case "base64decode":
                encodeResult = EncodeUtil().base64Decode(encodeStr)
            case "github2jsdelivr":
                encodeResult = jsDelivrSerivce().generateFromGithub(githubUrl: encodeStr)
            case "sha256":
                encodeResult = HashUtil().sha256(encodeStr)
            case "sha384":
                encodeResult = HashUtil().sha384(encodeStr)
            case "sha512":
                encodeResult = HashUtil().sha512(encodeStr)
            default:
                encodeResult = "error."
            }
        } else {
            alertText = "请输入内容"
            showingAlert = true
        }
    }
}
