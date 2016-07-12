//
//  CWVoicePlayer.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/12.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import AVFoundation

class CWVoicePlayer: NSObject {

    private var player: AVAudioPlayer?
    private var message: CWMessageModel?
    
    //初始化
    override init() {
        super.init()
        changeProximityMonitorEnableState(true)
        UIDevice.currentDevice().proximityMonitoringEnabled = false
    }

    init(message: CWMessageModel) {
        super.init()
        self.message = message
        prepareToPlay()
    }
    
    func playAudioWithMessage(message: CWMessageModel) {
        self.message = message
        prepareToPlay()
    }
    
    /**
     准备播放
     */
    func prepareToPlay() {
        
        guard let voiceMessage = message?.messageContent as? CWVoiceMessageContent,
              let voicePath = voiceMessage.voicePath else {
            return
        }
        let filePath = CWUserAccount.sharedUserAccount().pathUserChatVoice(voicePath)
        do {
            player = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: filePath))
            player?.prepareToPlay()
            player?.delegate = self
        } catch {
            print(error)
        }
    }
    
    func startPlay() {
        if (player?.playing == true) {
            player?.stop()
        } else {
            player?.play()
        }
    }
    
    /**
     停止播放
     */
    func stopPlay() {
        if (player?.playing == true) {
            player?.stop()
        }
    }
    
    
    deinit {
        changeProximityMonitorEnableState(false)
    }
    

    // MARK: 传感器
    //近距离传感器
    func changeProximityMonitorEnableState(enable:Bool) {
        UIDevice.currentDevice().proximityMonitoringEnabled = true
        if UIDevice.currentDevice().proximityMonitoringEnabled {
            //添加近距离事件监听，添加前先设置为YES，如果设置完后还是NO的读话，说明当前设备没有近距离传感器
            if enable {
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(sensorStateChange(_:)), name: UIDeviceProximityStateDidChangeNotification, object: nil)
            } else {
                NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceProximityStateDidChangeNotification, object: nil)
                UIDevice.currentDevice().proximityMonitoringEnabled = false
            }
            
        }
    }
    
    //事件
    func sensorStateChange(notification:NSNotificationCenter) {
        let state = UIDevice.currentDevice().proximityState
        if state {
            try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
        } else {
            try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            if player == nil || player?.playing == false {
                UIDevice.currentDevice().proximityMonitoringEnabled = false
            }
        }
        
    }
    
}

extension CWVoicePlayer: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        
        self.player!.stop()
        self.player = nil
        print("播放完成...")
    }
    
}


