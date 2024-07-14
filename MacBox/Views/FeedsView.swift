//
//  FeedsView.swift
//  MacBox
//
//  Created by zzh on 2024/7/12.
//

import SwiftUI

struct FeedsView: View {
    @State var errStr = "Hello, World!"
    var body: some View {
        VStack {
            Text(errStr)
        }.onAppear {
            FeedsService().getWeiboHot { data in
                print(data)
            } fail: { err in
                errStr = err
            }
        }
    }
}

#Preview {
    FeedsView()
}
