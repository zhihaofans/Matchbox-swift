//
//  LoginService.swift
//  MacBox
//
//  Created by zzh on 2024/6/1.
//

import Foundation
import Alamofire
class LoginService{
    func getWebLoginQrcode(callback: @escaping(String)->Void,fail: @escaping(String)->Void){
        AF.request("https://passport.bilibili.com/x/passport-login/web/qrcode/generate").responseJSON { response in
            switch response.result {
            case .success:
                debugPrint(response.value as Any)
                if let dict = response.value as? [String: Any] {
                    if let data = dict["data"] as? [String: Any] {
                        
                        if let qrcode_key = data["qrcode_key"] as? String {
                            callback(qrcode_key)
                        }else{
                            
                            fail("返回空白网址")
                        }
                    }else{
                        
                        fail("返回空白数据")
                    }
                }else{
                    fail("返回空白")
                }
                
            case let .failure(error):
                print(error)
                fail(error.localizedDescription)
            }
        }
    }
    
    func checkWebLoginQrcode(qrcodeKey:String,callback: @escaping(String)->Void,fail: @escaping(String)->Void){
        AF.request("https://passport.bilibili.com/x/passport-login/web/qrcode/poll?qrcode_key="+qrcodeKey).responseJSON { response in
            switch response.result {
            case .success:
                debugPrint(response.value as Any)
                if let dict = response.value as? [String: Any] {
                    if let data = dict["data"] as? [String: Any] {
                        
                        if let url = data["url"] as? String {
                            callback(url)
                        }else{
                            
                            fail("返回空白网址")
                        }
                    }else{
                        
                        fail("返回空白数据")
                    }
                }else{
                    fail("返回空白")
                }
                
            case let .failure(error):
                print(error)
                fail(error.localizedDescription)
            }
        }
    }
    
}
