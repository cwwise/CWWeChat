//
//  CWResourceService.swift
//  CWWeChat
//
//  Created by wei chen on 2017/9/4.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation

class CWResourceService: NSObject{
    
    override init() {
        super.init()
    }
    
}

extension CWResourceService: CWResourceManager {
    
    func upload(filepath: String, progress: CWResourceProgressBlock) {
        
        
        
        
    }
    
    func download(fileUrl: URL, filepath: String, progress: CWResourceProgressBlock) {
        
    }
    
    
}
