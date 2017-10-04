//
//  ChatKit.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation
import Kingfisher
import ChatClient

public class ChatKit: NSObject {
    
    public static let share = ChatKit()

    public var currentAccount: String {
        return ChatClient.share.currentAccount
    }
    
    private override init() {

        
        
        
        
    }
    
    
    public func fetchUser(userId: String) -> User? {
        return nil
    }
    
    public func fetchGroup(groupId: String) -> Group? {
        return nil
    }
    
    
}
