//
//  ToolsView.swift
//  MacBox
//
//  Created by zzh on 2024/6/8.
//

import NaturalLanguage
import SwiftUI
import SwiftUtils

struct ToolsView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("工具", destination: ToolsOldView())
                NavigationLink(destination: Text("Detail View")) {
                    Text("工具")
                        .font(.largeTitle) // 设置字体大小
                }
                NavigationLink("二维码", destination: QrcodeView())
                NavigationLink("编码", destination: EncodeView())
                NavigationLink("文本分词", destination: FenciView())
                NavigationLink("系统信息", destination: SysInfoView())
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("工具")
            /* .toolbar {
                 ToolbarItem(placement: .automatic) {
                     NavigationLink(destination: MainView()) {
                         // TODO: 这里跳转到个人页面或登录界面
                         Image(systemName: "person")
                     }
                 }
             } */
        }
        .frame(minWidth: 800, minHeight: 600) // 设置窗口的最小尺寸
    }
}

struct ToolsOldView: View {
    @State private var showingAlert = false
    @State private var showingQrcodeAlert = false
    @State private var showingjsDelivrAlert = false
    @State private var githubUrl = "https://github.com/zhihaofans/macbox-swift/blob/main/MacBox/Views/ToolsView.swift"
    @State private var textStr = "Hello, Tools!"
    var body: some View {
        Text(textStr)

        Button(action: {
            // TODO:
        }) {
            Text("实况图片").font(.title)
        }
    }
}

struct FenciView: View {
    @State private var input = ""
    @State private var fenciList: [String] = []
    @State private var fenciUnit: NLTokenUnit = .word
    var body: some View {
        VStack {
            TextField("输入要分词的文本", text: $input).onChange(of: input) { _, _ in
                fenciList = FenciUtil(fenciUnit).fenci(input)
            }
            List(fenciList, id: \.self) {
                Text($0)
            }
        }
    }
}

struct SysInfoView: View {
    private let deviceUtil = DeviceUtil()
    var body: some View {
        VStack {
            List {
                SimpleTextItemView(title: "MacOS", detail: deviceUtil.isMac().string(trueStr: "✅", falseStr: "❌"))
                SimpleTextItemView(title: "WatchOS", detail: deviceUtil.isWatch().string(trueStr: "✅", falseStr: "❌"))
                SimpleTextItemView(title: "OS ver", detail: deviceUtil.getSystemVersion())
//                SimpleTextItemView(title: "电量", detail: self.getBatteryLevel().toString + "%")
            }
        }
    }

    private func getBatteryLevel() -> Int {
        let process = Process()
        let pipe = Pipe()

        // 设置要运行的命令，这里是 system_profiler，路径为 /usr/sbin/system_profiler
        process.executableURL = URL(fileURLWithPath: "/usr/sbin/system_profiler")
        // 设置命令的参数，只获取电源相关的数据
        process.arguments = ["SPPowerDataType"]
        // 设置输出管道，将命令的输出重定向到这个管道
        process.standardOutput = pipe
        do {
            // 启动进程
            try process.run()
            // 等待进程完成
            process.waitUntilExit()

            // 从管道读取数据，转换为字符串
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            if let output = String(data: data, encoding: .utf8) {
                // print(output)
                // 解析电池信息
                let lines = output.split(separator: "\n")
                print(lines)
                var batteryFull = 0
                var batteryNow = 0
                var batteryLevel = 0
                for line in lines {
                    // 查找并打印剩余电量
                    if line.contains("Charge Remaining (mAh):") {
                        batteryNow = Int(line.trimmingCharacters(in: .whitespaces)) ?? -1
                        print(batteryNow)
                    }
                    // 查找并打印是否充满电
                    if line.contains("Fully Charged:") {
                        print(line.trimmingCharacters(in: .whitespaces))
                    }
                    // 查找并打印是否正在充电
                    if line.contains("Charging:") {
                        print(line.trimmingCharacters(in: .whitespaces))
                    }
                    // 查找并打印满充电量
                    if line.contains("Full Charge Capacity (mAh):") {
                        batteryFull = Int(line.trimmingCharacters(in: .whitespaces)) ?? -1
                        print(batteryFull)
                    }
                    // 查找并打印满充电量
                    if line.contains("State of Charge (%):") {
                        batteryLevel = Int(line.trimmingCharacters(in: .whitespaces)) ?? -1
                        print(batteryLevel)
                    }
                }
//                if batteryNow <= 0 || batteryFull <= 0 {
//                    return -1
//                } else {
//                    return Int((batteryNow / batteryFull) * 100)
//                }
                return batteryLevel
            } else {
                return -1
            }
        } catch {
            // 如果命令执行失败，打印错误信息
            print("Failed to fetch battery info: \(error)")
            return -1
        }
    }
}
