//
//  CWAccount.swift
//  CWWeChat
//
//  Created by wei chen on 2017/9/16.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

class CWAccount: NSObject, Codable {

    var isLogin: Bool = false
    
    var username: String
    
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

extension CWAccount {
    
    func save() throws {
        let path = UIApplication.shared.documentsDirectoryPath + "/account"
        let pathURL = URL(fileURLWithPath: path)
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        try data.write(to: pathURL)
    }
    
    static func userAccount() throws -> CWAccount {
        let path = UIApplication.shared.documentsDirectoryPath + "/account"
        let pathURL = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: pathURL)
        let decoder = JSONDecoder()
        let account = try decoder.decode(CWAccount.self, from: data)
        return account
    }
    
}
