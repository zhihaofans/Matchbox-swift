//
//  MacBoxApp.swift
//  MacBox
//
//  Created by zzh on 2024/5/29.
//

import SwiftUI

@main
struct MacBoxApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        WindowGroup("Settings") {
            SettingView()
        }
        .handlesExternalEvents(matching: Set(arrayLiteral: "openSettings"))
    }
}
