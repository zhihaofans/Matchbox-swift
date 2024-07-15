//
//  FeedsService.swift
//  MacBox
//
//  Created by zzh on 2024/7/13.
//

import Foundation

class FeedsService {
    private let httpService = HttpService()
    func getWeiboHot(callback: @escaping ([FeedsItem])->Void, fail: @escaping (String)->Void) {
        let url = "https://api.weibo.cn/2/guest/page?skin=default&c=iphone&lang=zh_CN&did=28702ff365175bb6ec73bdae54e983b6&sflag=1&s=05255a73&ua=iPhone12,3__weibo__10.3.2__iphone__os13.3.1&aid=01A60TsNDLJjHThSBRYl3stFkRvAJVswLxyxIuyR3_42GI-kI.&wm=3333_2001&sensors_device_id=56ADFCCB-9F4A-4E98-84DE-11029AF0EAAA&sensors_is_first_day=false&v_f=1&sensors_mark=0&ft=1&uid=1014452611945&v_p=82&gsid=_2AkMqh0bzf8NhqwJRmfwRyWnkbYx-zg3EieKc27coJRM3HRl-wT9jql0_tRV6AQdoHM8DSWqdK4Z63hMK72vKbWKfXkxW&from=10A3293010&networktype=wifi&checktoken=da33e09bb260669c0c46ac5ae1f841ad&b=0&page_interrupt_enable=0&extparam=pos%253D0_0%2526mi_cid%253D100103%2526cate%253D10103%2526filter_type%253Drealtimehot%2526c_type%253D30%2526display_time%253D1585013533&orifid=231619&count=20&luicode=10000512&containerid=106003type%3D25%26t%3D3%26disable_hot%3D1%26filter_type%3Drealtimehot&featurecode=10000512&uicode=10000011&fid=106003type%3D25%26t%3D3%26disable_hot%3D1%26filter_type%3Drealtimehot&st_bottom_bar_new_style_enable=0&need_new_pop=1&page=1&client_key=4654bde8da914bb619fd60a5c1e8cc5d&lfid=231619&moduleID=pagecard&oriuicode=10000512&launchid=10000365--x"

        self.httpService.get(url: url) { result in
            print(result)
            do {
                if result.has(keyword: "{"), result.has(keyword: "}") {
                    debugPrint("weibo.JSONDecoder.start")
                    let data = try JSONDecoder().decode(WeiboHotResult.self, from: result.data(using: .utf8)!)
                    let hotData=data.cards[0]
                    let hotList=hotData.card_group
                    let feedsList=hotList.map { 
                        let it=$0
                        FeedsItem(id: it.itemId ?? UUID(), title: it.desc ?? "空白标题", desc: "", url: it.scheme??"", author: hotData.title, cover: it.pic??"")
                    }
                    print(feedsList)
                    debugPrint("weibo.JSONDecoder.end")
                    callback(feedsList)
                } else {
                    fail("feeds.weibo.notjson:" + result)
                }
            } catch {
                print(error)
                fail("feeds.weibo:" + error.localizedDescription.debugDescription)
            }
        } fail: { err in
            fail(err)
        }
    }
}
