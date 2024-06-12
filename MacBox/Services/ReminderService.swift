//
//  ReminderService.swift
//  MacBox
//
//  Created by zzh on 2024/6/11.
//

import Foundation
import SwiftData

class ReminderDataService {
    static var shared = ReminderDataService()
    var container: ModelContainer?
    var context: ModelContext?
    init() {
        do {
            container = try ModelContainer(for: ReminderItemModel.self)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            print(error)
        }
    }
    
    // 增加
    func insert(reminderItem: ReminderItemModel) {
        context?.insert(reminderItem)
    }

    // 删除
    func delete(reminderItem: ReminderItemModel) {
        context?.delete(reminderItem)
    }

    // 修改
    func update(reminderItem: ReminderItemModel, newTitle: String, newTimestamp: Int) {
        reminderItem.title = newTitle
        reminderItem.timestamp = newTimestamp
    }

    // 查询
    func select(completionHandler: @escaping ([ReminderItemModel]?, Error?) -> Void) {
        let descriptor = FetchDescriptor<ReminderItemModel>(sortBy: [SortDescriptor<ReminderItemModel>(\.timestamp)])
        do {
            let data = try context?.fetch(descriptor)
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }
    }

    // 保存
    func save() {
        do {
            try context?.save()
        } catch {
            print(error.localizedDescription)
        }
    }

}

