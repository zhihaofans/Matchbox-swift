//
//  HttpService.swift
//  MacBox
//
//  Created by zzh on 2024/7/14.
//

import Alamofire
import Foundation

class HttpService {
    private let headers = ""
    //func init() {}

    func get(url: String, callback: @escaping (String)->Void, fail: @escaping (String)->Void) {
        AF.request(url).responseString { response in
            switch response.result {
            case let .success(value):
                callback(value)
            case let .failure(error):
                print(error)
                fail(error.localizedDescription)
            }
        }
    }
}
