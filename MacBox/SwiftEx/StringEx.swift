//
//  StringEx.swift
//  MacBox
//
//  Created by zzh on 2024/6/13.
//

import Foundation

extension String {
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
    var isInt: Bool {
      return Int(self) != nil
    }
}
