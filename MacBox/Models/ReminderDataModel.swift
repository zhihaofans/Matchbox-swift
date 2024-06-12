//
//  ReminderDataModel.swift
//  MacBox
//
//  Created by zzh on 2024/6/10.
//

import Foundation
import SwiftData
@Model
class ReminderItemModel {
    var uuid = UUID()
    var title: String
    var desc: String
    var timestamp: Int
    init(title: String, desc: String = "", timestamp: Int) {
        // self.UUID = UUID
        self.title = title
        self.timestamp = timestamp
        self.desc = desc
    }
}
