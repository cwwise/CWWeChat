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
    func audioRecordUpdateMetra(_ metra: Float)
    
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
    func audioRecordFinish(_ filename: String, recordTime: Float)
}

class CWVoiceRecorder: NSObject {

    var delegate: CWVoiceRecorderDelegate?
    /// 最大录音时间
    let maxRecordTime: CGFloat = 60
    
    var operationQueue: OperationQueue
    
    fileprivate var startTime: CFTimeInterval! //录音开始时间
    fileprivate var endTimer: CFTimeInterval! //录音结束时间
    fileprivate var audioTimeInterval: NSNumber!
    fileprivate var isFinishRecord: Bool = true
    fileprivate var isCancelRecord: Bool = false
    
    fileprivate let recordSettings = [AVSampleRateKey : NSNumber(value: Float(44100.0) as Float),//声音采样率
                                  AVFormatIDKey : NSNumber(value: Int32(kAudioFormatLinearPCM) as Int32),//编码格式
                                  AVNumberOfChannelsKey : NSNumber(value: 1 as Int32),//采集音轨
                                  AVEncoderAudioQualityKey : NSNumber(value: Int32(AVAudioQuality.medium.rawValue) as Int32)]//音频质量
    fileprivate var audioRecorder:AVAudioRecorder!
    
    var voiceName: String = {
        let random = arc4random() % 1000
        let voiceName = String(format: "\(String.UUIDString())%04d.wav", random)
        return voiceName
    }()
    
    lazy fileprivate var directoryURL:URL = {
        let filePath = ""
        return URL(fileURLWithPath: filePath)
    }()
    
    
    override init() {
        self.operationQueue = OperationQueue()
        super.init()

        let audioSession = AVAudioSession.sharedInstance()
        audioSession.requestRecordPermission { (result) in
            if result {
                do {
                    try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                    try self.audioRecorder = AVAudioRecorder(url: self.directoryURL,
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
        if audioRecorder.isRecording == false {
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setActive(true)
                audioRecorder.record()
                
                let operation = BlockOperation()
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
        
        self.audioTimeInterval = NSNumber(value: NSNumber(value: self.audioRecorder.currentTime as Double).int32Value as Int32)
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
        } catch {
            log.error(error)
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
            self.audioTimeInterval = NSNumber(value: NSNumber(value: recorder.currentTime as Double).floatValue as Float)
            let averagePower = recorder.averagePower(forChannel: 0)
            let lowPassResults = pow(10, (0.05 * averagePower)) * 10
            
            DispatchQueue.main.async(execute: { 
                self.delegate?.audioRecordUpdateMetra(lowPassResults)
            })
            //如果大于 60 ,停止录音
            if self.audioTimeInterval.int32Value > 60 {
                self.stopRecord()
            }
            
            Thread.sleep(forTimeInterval: 0.05)
        } while(recorder.isRecording)
    }
    
}

extension CWVoiceRecorder: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        log.debug("录音路径--\(self.voiceName) \(flag)")
        if flag && self.isFinishRecord {
            if let delegate = self.delegate {
                delegate.audioRecordFinish(self.voiceName, recordTime: self.audioTimeInterval.floatValue)
            }
        }
    }
    
}

