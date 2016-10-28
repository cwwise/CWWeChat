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

    fileprivate var player: AVAudioPlayer?
    fileprivate var message: CWMessageModel?
    
    
    //初始化
    override init() {
        super.init()
        changeProximityMonitorEnableState(true)
        UIDevice.current.isProximityMonitoringEnabled = false
    }

    init(message: CWMessageModel) {
        super.init()
        self.message = message
        prepareToPlay()
    }
    
    func playAudioWithMessage(_ message: CWMessageModel) {
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
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePath))
            player?.prepareToPlay()
            player?.delegate = self
        } catch {
            print(error)
        }
    }
    
    
    func startPlay() {
        if (player?.isPlaying == true) {
            player?.stop()
        } else {
            player?.play()
        }
    }
    
    /**
     停止播放
     */
    func stopPlay() {
        if (player?.isPlaying == true) {
            player?.stop()
        }
    }
    
    deinit {
        changeProximityMonitorEnableState(false)
    }
    

    // MARK: 传感器
    //近距离传感器
    func changeProximityMonitorEnableState(_ enable:Bool) {
        UIDevice.current.isProximityMonitoringEnabled = true
        if UIDevice.current.isProximityMonitoringEnabled {
            //添加近距离事件监听，添加前先设置为YES，如果设置完后还是NO的读话，说明当前设备没有近距离传感器
            if enable {
                NotificationCenter.default.addObserver(self, selector: #selector(sensorStateChange(_:)), name: NSNotification.Name.UIDeviceProximityStateDidChange, object: nil)
            } else {
                NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceProximityStateDidChange, object: nil)
                UIDevice.current.isProximityMonitoringEnabled = false
            }
            
        }
    }
    
    //事件
    func sensorStateChange(_ notification:NotificationCenter) {
        let state = UIDevice.current.proximityState
        if state {
            try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
        } else {
            try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            if player == nil || player?.isPlaying == false {
                UIDevice.current.isProximityMonitoringEnabled = false
            }
        }
        
    }
    
}

extension CWVoicePlayer: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        self.player!.stop()
        self.player = nil
        print("播放完成...")
    }
    
}


