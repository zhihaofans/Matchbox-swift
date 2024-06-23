//
//  KeychainView.swift
//  MacBox
//
//  Created by zzh on 2024/6/23.
//

import Security
import SwiftUI

struct KeychainView: View {
    @Binding var showPageId: String
    @State private var inputKey = ""
    @State private var inputValue = ""
    @State private var alertShow = false
    @State private var alertMsg = ""
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        TextField("Key", text: $inputKey)
        TextField("Value", text: $inputValue)
        Button(action: {
            if inputKey.isEmpty {
                alertMsg = "inputKey.isEmpty"
                alertShow = true
            } else if inputValue.isEmpty {
                alertMsg = "inputValue.isEmpty"
                alertShow = true
            } else {
                let resu = self.setKeychain(forKey: inputKey, value: inputValue)
                alertMsg = resu.string(trueStr: "保存成功", falseStr: "保存失败")
                alertShow = true
            }
        }) {
            Text("Commit").font(.title)
        }
        .alert("错误", isPresented: $alertShow) {
            Button("OK", action: {})
        } message: {
            Text(alertMsg)
        }
        Button(action: {
            if inputKey.isEmpty {
                alertMsg = "inputKey.isEmpty"
                alertShow = true
            } else if inputValue.isEmpty {
                alertMsg = "inputValue.isEmpty"
                alertShow = true
            } else {
                let resu = self.updateKeychain(forKey: inputKey, value: inputValue)
                alertMsg = resu.string(trueStr: "更新成功", falseStr: "更新失败")
                alertShow = true
            }
        }) {
            Text("Update").font(.title)
        }
        .alert("错误", isPresented: $alertShow) {
            Button("OK", action: {})
        } message: {
            Text(alertMsg)
        }
        Button(action: {
            if inputKey.isEmpty {
                alertMsg = "inputKey.isEmpty"
                alertShow = true
            } else {
                let loadValue = self.getKeychain(forKey: inputKey)
                if loadValue == nil {
                    alertMsg = "value = nil"
                    alertShow = true
                } else {
                    inputValue = loadValue!
                }
            }
        }) {
            Text("Load").font(.title)
        }
        Button(action: {
            if inputKey.isEmpty {
                alertMsg = "inputKey.isEmpty"
                alertShow = true
            } else {
                let removeSu = self.removeKeychain(forKey: inputKey)
                alertMsg = removeSu.string(trueStr: "删除成功", falseStr: "删除失败")
                alertShow = true
            }
        }) {
            Text("Remove").font(.title)
        }
    }

    private func updateKeychain(forKey key: String, value: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]

        // 指定新的数据
        let attributesToUpdate: [String: Any] = [
            kSecValueData as String: data
        ]

        let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
        // 检查操作是否成功
        if status == errSecSuccess {
            print("Item updated successfully.")
            return true
        } else {
            print("Failed to update item with error code: \(status).")
            return false
        }
    }

    private func setKeychain(forKey key: String, value: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }

    private func removeKeychain(forKey key: String) -> Bool {
        // 定义一个查询，用于指定要删除的 Keychain 条目
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]

        // 执行删除操作
        let status = SecItemDelete(query as CFDictionary)

        // 检查操作是否成功
        if status == errSecSuccess {
            print("Item deleted successfully.")
            return true
        } else {
            print("Failed to delete item with error code: \(status).")
            return false
        }
    }

    private func getKeychain(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        guard status == errSecSuccess,
              let data = dataTypeRef as? Data,
              let value = String(data: data, encoding: .utf8) else { return nil }

        return value
    }
}
