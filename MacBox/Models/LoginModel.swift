//
//  LoginModel.swift
//  MacBox
//
//  Created by zzh on 2024/6/3.
//

import Foundation

struct QrcodeResultModel: Identifiable {
    let id = UUID()
    let code:Int
    let message: String
    let qrcode_key: String?
    let url: String?
}
