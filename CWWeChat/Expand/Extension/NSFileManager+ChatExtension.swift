//
//  NSFileManager+ChatExtension.swift
//  CWWeChat
//
//  Created by chenwei on 16/4/6.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation
import UIKit

extension FileManager {
    
    class func saveContentImage(_ image: UIImage?,imagePath path:String) {
        guard let image = image , FileManager.default.fileExists(atPath: path) == false else {
            return
        }
        var data = UIImageJPEGRepresentation(image, 1)
        if data == nil {
            data = UIImagePNGRepresentation(image)
        }
        if FileManager.default.createFile(atPath: path, contents: data, attributes: nil) {

        }
    }
}

