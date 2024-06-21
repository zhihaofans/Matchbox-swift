//
//  EncodeView.swift
//  MacBox
//
//  Created by zzh on 2024/6/19.
//

import SwiftUI
import SwiftUtils

struct EncodeView: View {
    @Binding var showPageId: String
    @State private var encodeMode = "urlencode"
    @State private var encodeStr = ""
    @State private var selectedFlavor = ""
    @State private var encodeResult = ""
    @State private var showingAlert = false
    @State private var alertTitle = "错误"
    @State private var alertText = "未知错误"
    var body: some View {
        Picker("模式", selection: $encodeMode) {
            Text("Url编码").tag("urlencode")
            Text("Url解码").tag("urldecode")
            Text("Base64编码").tag("base64encode")
            Text("Base64解码").tag("base64decode")
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

    private func auto() {
        if encodeStr.isNotEmpty {
            switch encodeMode.lowercased() {
            case "urlencode":
                encodeResult = EncodeUtil().urlEncode(oldString: encodeStr)
            case "urldecode":
                encodeResult = EncodeUtil().urlDecode(oldString: encodeStr)
            case "base64encode":
                encodeResult = EncodeUtil().base64Encode(oldString: encodeStr)
            case "base64decode":
                encodeResult = EncodeUtil().base64Decode(oldString: encodeStr)
            case "github2jsdelivr":
                encodeResult = jsDelivrSerivce().generateFromGithub(githubUrl: encodeStr)
            default:
                encodeResult = "error."
            }
        } else {
            encodeResult = "isEmpty."
        }
    }
}
