//
//  ListItemView.swift
//  MacBox
//
//  Created by zzh on 2024/10/3.
//

import SwiftUI

struct SimpleTextItemView: View {
    var title: String
    var detail: String

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(detail).foregroundColor(.gray)
        }
    }
}
