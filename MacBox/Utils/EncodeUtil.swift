//
//  EncodeUtil.swift
//  MacBox
//
//  Created by zzh on 2024/6/13.
//

import Foundation

class EncodeUtil {
    func UrlEncode(oldString: String) -> String {
        return oldString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? oldString
    }

    func UrlDecode(oldString: String) -> String {
        return oldString.removingPercentEncoding() ?? oldString
    }
}
