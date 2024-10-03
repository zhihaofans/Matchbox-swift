//
//  ReminderView.swift
//  MacBox
//
//  Created by zzh on 2024/6/10.
//

import SwiftData
import SwiftUI
import SwiftUtils

struct ReminderView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var path = [ReminderItemModel]()
    // 默认排序方式
    @State private var sortOrder = SortDescriptor(\ReminderItemModel.timestamp, order: .reverse)

    var body: some View {
        NavigationStack(path: $path) {
            TodoListView(sort: sortOrder)
                .navigationDestination(for: ReminderItemModel.self) { reminderItem in
                    EditView(reminderItem: reminderItem)
                }
                .navigationTitle("ReminderList")
                .toolbar {
                    // 增加数据
                    /* Button("Home", systemImage: "house", action: {
                         showPageId = "main"
                     }) */
                    Button("Add", systemImage: "plus", action: addItem)

                    // 修改排序方式
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("标题")
                                .tag(SortDescriptor(\ReminderItemModel.title, order: .reverse))

                            Text("日期")
                                .tag(SortDescriptor(\ReminderItemModel.timestamp, order: .reverse))
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }

    func addItem() {
        let reminderItem = ReminderItemModel(title: "test", desc: "", timestamp: DateUtil().getTimestamp())
        modelContext.insert(reminderItem)
        path = [reminderItem]
    }
}

// MARK: - TodoListView

struct TodoListView: View {
    @Environment(\.modelContext) private var modelContext
    // 4. 查询并排序
    @Query private var reminderItems: [ReminderItemModel]

    init(sort: SortDescriptor<ReminderItemModel>) {
        _reminderItems = Query(sort: [sort])
    }

    var body: some View {
        if reminderItems.isEmpty {
            ContentUnavailableView.search
        } else {
            List {
                ForEach(reminderItems) { reminderItem in
                    NavigationLink(value: reminderItem) {
                        HStack {
                            Text(reminderItem.title)

                            Spacer()

                            Text(DateUtil().timestampToTimeStr(reminderItem.timestamp))
                        }
                    }
                }
                .onDelete(perform: deletedTodoItem)
            }
        }
    }

    // 2. 删除
    func deletedTodoItem(_ indexSet: IndexSet) {
        for index in indexSet {
            let reminderItem = reminderItems[index]
            modelContext.delete(reminderItem)
        }
    }
}

// MARK: - EditView

struct EditView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var reminderItem: ReminderItemModel

    var body: some View {
        Form {
            // 3. 修改

            Text("请输入标题!").font(.largeTitle)
            TextField("标题:", text: $reminderItem.title)
            Text("创建时间:" + DateUtil().timestampToTimeStr(reminderItem.timestamp)).font(.largeTitle)
            Button(action: {}) {
                Text("").font(.title)
            }
        }
        .padding()
        .navigationTitle("编辑")
    }
}

/*
 #Preview {
     ReminderView(showPageId: "reminder")
 }

 */
