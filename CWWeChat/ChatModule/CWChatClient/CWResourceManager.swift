//
//  CWResourceManager.swift
//  CWWeChat
//
//  Created by wei chen on 2017/9/4.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation

typealias CWResourceProgressBlock = (Float) -> Void

/// 文件上传下载
protocol CWResourceManager: NSObjectProtocol {
    
    func upload(filepath: String, progress: CWResourceProgressBlock)
    
    func download(fileUrl: URL, filepath: String, progress: CWResourceProgressBlock)
    
}
