//
//  EncodeUtil.swift
//  MacBox
//
//  Created by zzh on 2024/6/13.
//

import Foundation

class EncodeUtil {
    func UrlEncode(oldString: String) -> String {
        if oldString.isEmpty {
            return ""
        } else {
            return oldString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? oldString
        }
    }

    func UrlDecode(oldString: String) -> String {
        if let decodedString = oldString.removingPercentEncoding {
            return decodedString
        } else {
            return oldString
        }
    }
}
