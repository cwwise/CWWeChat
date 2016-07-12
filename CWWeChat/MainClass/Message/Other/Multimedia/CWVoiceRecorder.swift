//
//  CWVoiceRecorder.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/12.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

import AVFoundation

protocol CWVoiceRecorderDelegate {
    
    func voiceRecorder(success: Bool, recordname filename:String)
}

class CWVoiceRecorder: NSObject {

    var delegate: CWVoiceRecorderDelegate?
    /// 最大录音时间
    let maxRecordTime: CGFloat = 60
    /// 当前时间
    let currentTimeInterval: NSTimeInterval = 0
    /// 定时器
    var timer:NSTimer?
    
    private let recordSettings = [AVSampleRateKey : NSNumber(float: Float(44100.0)),//声音采样率
                                  AVFormatIDKey : NSNumber(int: Int32(kAudioFormatLinearPCM)),//编码格式
                                  AVNumberOfChannelsKey : NSNumber(int: 1),//采集音轨
                                  AVEncoderAudioQualityKey : NSNumber(int: Int32(AVAudioQuality.Medium.rawValue))]//音频质量
    
    private var audioRecorder:AVAudioRecorder!
    
    var voiceName: String = {
        let random = arc4random() % 1000
        let voiceName = String(format: "\(String.UUIDString())%04d.wav", random)
        return voiceName
    }()
    
    lazy private var directoryURL:NSURL = {
        let filePath = CWUserAccount.sharedUserAccount().pathUserChatVoice(self.voiceName)
        return NSURL(fileURLWithPath: filePath)
    }()
    
    
    override init() {
        super.init()
        
        let audioSession = AVAudioSession.sharedInstance()
        audioSession.requestRecordPermission { (result) in
            if result {
                do {
                    try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                    try self.audioRecorder = AVAudioRecorder(URL: self.directoryURL,
                        settings: self.recordSettings)//初始化实例
                    self.audioRecorder.delegate = self
                    self.audioRecorder.prepareToRecord()//准备录音
                } catch {
                    print(error)
                }
            }
        }
    }
    
    ///开始录音
    func startRecord() {
        guard let audioRecorder = audioRecorder else {
            return
        }
        if audioRecorder.recording == false {
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setActive(true)
                audioRecorder.record()
            } catch {
                
            }
        }
    }
    
    func cancelRecord() -> Bool {
        audioRecorder.stop()
        return audioRecorder.deleteRecording()
    }
    
    ///停止录音
    func stopRecord() {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
        } catch let error as NSError {
            CWLogError(error)
        }
    }
    
    func updateAudio() {
        
    }
    
}

extension CWVoiceRecorder: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        CWLogDebug("录音路径--\(self.voiceName) \(flag)")
        if flag == true {
            if let delegate = self.delegate {
                delegate.voiceRecorder(flag, recordname: voiceName)
            }
        }
    }
    
}

