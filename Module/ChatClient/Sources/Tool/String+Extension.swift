//
//  String+Extension.swift
//  ChatClient
//
//  Created by chenwei on 2018/3/21.
//

import Foundation

extension Dictionary {
    var jsonEncoded: String {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: data, encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
}

extension Array {
    var jsonEncoded: String {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: data, encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
}
