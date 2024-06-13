//
//  BoolEx.swift
//  MacBox
//
//  Created by zzh on 2024/6/13.
//

import Foundation

extension Bool {
    func string(trueStr: String, falseStr: String) -> String {
        return if self {
            trueStr
        } else {
            falseStr
        }
    }
}
