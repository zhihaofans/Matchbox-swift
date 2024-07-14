//
//  FeedsModel.swift
//  MacBox
//
//  Created by zzh on 2024/6/10.
//

import Foundation

struct WeiboHotResult: Codable {
    let cards: [WeiboHotCardItem]?
}

struct WeiboHotCardItem: Codable {
    let card_group: [WeiboHotCardGroupItem]?
    //let show_type: Int
    //let card_type: Int
    //let itemid: String
    let title: String?
    //let openurl: String
}

struct WeiboHotCardGroupItem: Codable {
    let desc: String?
    let card_type: Int?
    let itemid: String?
    let pic: String?
    let scheme: String?
}

class FeedsItem {
    var id: String
    var title: String
    var desc: String
    var url: String
    var author: String
    var cover: String
    // TODO: 生成init()
    init(id: String, title: String, desc: String, url: String, author: String, cover: String) {
        self.id = id
        self.title = title
        self.desc = desc
        self.url = url
        self.author = author
        self.cover = cover
    }
}
