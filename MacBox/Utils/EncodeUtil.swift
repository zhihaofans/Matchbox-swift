//
//  EncodeUtil.swift
//  MacBox
//
//  Created by zzh on 2024/6/13.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins
class EncodeUtil{
  func UrlEncode(oldString:String)-> String{
    if oldString.isEmpty(){
      return ""
    }else{
      return oldString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
  }
}
