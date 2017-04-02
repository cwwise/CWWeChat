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

    class func playSoundEffect(_ fileName: String) {
        let audioFile = Bundle.main.path(forResource: fileName, ofType: nil)
        let fileUrl = URL(fileURLWithPath: audioFile!)
        
        var soundID: SystemSoundID = 0
        
        AudioServicesCreateSystemSoundID(fileUrl as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
    
}
