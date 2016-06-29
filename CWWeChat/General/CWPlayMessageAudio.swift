//
//  CWPlayMessageAudio.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/30.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import AudioToolbox

class CWPlayMessageAudio: NSObject {

    class func playSoundEffect(fileName: String) {
        let audioFile = NSBundle.mainBundle().pathForResource(fileName, ofType: nil)
        let fileUrl = NSURL.fileURLWithPath(audioFile!)
        
        var soundID: SystemSoundID = 0
        
        AudioServicesCreateSystemSoundID(fileUrl, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
    
}
