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
    /**
     更新进度 , 0.0 - 9.0, 浮点数
     */
    func audioRecordUpdateMetra(metra: Float)
    
    /**
     录音太短
     */
//    func audioRecordTooShort()
    
    
    /**
     录音失败
     */
//    func audioRecordFailed()
    
    /**
     取消录音
     */
//    func audioRecordCanceled()
    
    /**
     录音完成
     
     - parameter recordTime:        录音时长
     - parameter uploadAmrData:     上传的 amr Data
     */
    func audioRecordFinish(filename: String, recordTime: Float)
}

class CWVoiceRecorder: NSObject {

    var delegate: CWVoiceRecorderDelegate?
    /// 最大录音时间
    let maxRecordTime: CGFloat = 60
    
    var operationQueue: NSOperationQueue
    
    private var startTime: CFTimeInterval! //录音开始时间
    private var endTimer: CFTimeInterval! //录音结束时间
    private var audioTimeInterval: NSNumber!
    private var isFinishRecord: Bool = true
    private var isCancelRecord: Bool = false
    
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
        self.operationQueue = NSOperationQueue()
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
        
        self.isCancelRecord = false
        
        guard let audioRecorder = audioRecorder else {
            return
        }
        if audioRecorder.recording == false {
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setActive(true)
                audioRecorder.record()
                
                let operation = NSBlockOperation()
                operation.addExecutionBlock(updateMeters)
                self.operationQueue.addOperation(operation)
                
            } catch {
                
            }
        }
    }
    
    func cancelRecord() {
        
        self.isFinishRecord = false
        self.audioRecorder.stop()
        self.audioRecorder.deleteRecording()
        self.audioRecorder = nil
        
    }
    
    ///停止录音
    func stopRecord() {
        
        self.isFinishRecord = true
        self.isCancelRecord = false
        self.endTimer = CACurrentMediaTime()
        audioRecorder?.stop()
        
        self.audioTimeInterval = NSNumber(int: NSNumber(double: self.audioRecorder.currentTime).intValue)
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
        } catch let error as NSError {
            CWLogError(error)
        }
        self.operationQueue.cancelAllOperations()
    }
    
    /**
     更新进度
     */
    func updateMeters() {
        guard let recorder = self.audioRecorder else { return }
        repeat {
            recorder.updateMeters()
            self.audioTimeInterval = NSNumber(float: NSNumber(double: recorder.currentTime).floatValue)
            let averagePower = recorder.averagePowerForChannel(0)
            let lowPassResults = pow(10, (0.05 * averagePower)) * 10
            dispatch_async_safely_to_main_queue({ () -> () in
                self.delegate?.audioRecordUpdateMetra(lowPassResults)
            })
            //如果大于 60 ,停止录音
            if self.audioTimeInterval.intValue > 60 {
                self.stopRecord()
            }
            
            NSThread.sleepForTimeInterval(0.05)
        } while(recorder.recording)
    }
    
}

extension CWVoiceRecorder: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        CWLogDebug("录音路径--\(self.voiceName) \(flag)")
        if flag && self.isFinishRecord {
            if let delegate = self.delegate {
                delegate.audioRecordFinish(self.voiceName, recordTime: self.audioTimeInterval.floatValue)
            }
        }
    }
    
}

