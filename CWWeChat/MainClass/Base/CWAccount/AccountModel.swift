//
//  CWAccount.swift
//  CWWeChat
//
//  Created by wei chen on 2017/9/16.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

class AccountModel: Codable {

    var isLogin: Bool = false
    
    var username: String
    
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

extension AccountModel {

    // 做简单的处理 待完善
    func save() {
        let path = UIApplication.shared.documentsDirectoryPath + "/account"
        let pathURL = URL(fileURLWithPath: path)
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            try data.write(to: pathURL)
        } catch {

        }
    }
    
    static func userAccount() -> AccountModel? {
        let path = UIApplication.shared.documentsDirectoryPath + "/account"
        do {
            let pathURL = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: pathURL)
            let decoder = JSONDecoder()
            let account = try decoder.decode(AccountModel.self, from: data)
            return account
        } catch {
            return nil
        }
    }
    
}
