//
//  CWVoiceIndicatorView.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/13.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/// 录音的提示图
class CWVoiceIndicatorView: UIView {
    
    /// 取消提示
    lazy var cancelImageView: UIImageView = {
        let cancelImageView = UIImageView()
        cancelImageView.image = CWAsset.RecordCancel.image
        return cancelImageView
    }()
    
    /// 录音整体的 view，控制是否隐藏
    lazy  var recordingView: UIView = {
        let recordingView = UIView()
        recordingView.size = CGSize(width: 100, height: 100)
        return recordingView
    }()
    
    var voiceSignalImageView: UIImageView = {
        let voiceSignalImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 62, height: 100))
        voiceSignalImageView.image = CWAsset.RecordingBkg.image
        return voiceSignalImageView
    }()

    
    ///音量的图片
    var signalValueImageView: UIImageView = {
        let signalValueImageView = UIImageView(frame: CGRect(x: 62, y: 0, width: 38, height: 100))
        signalValueImageView.image = CWAsset.RecordingSignal001.image
        return signalValueImageView
    }()
    
    
    
    //录音时间太短的提示
    lazy var tooShotPromptImageView: UIImageView = {
        let tooShotPromptImageView = UIImageView()
        tooShotPromptImageView.image = CWAsset.MessageTooShort.image
        return tooShotPromptImageView
    }()
    
     //中央的灰色背景 view
//    var centerView: UIView! {
//        didSet {
//            centerView.layer.cornerRadius = 4.0
//            centerView.layer.masksToBounds = true
//        }
//    }
    
    //提示的 label
    lazy var noteLabel: UILabel = {
       let noteLabel = UILabel()
        noteLabel.textAlignment = .center
        noteLabel.text = "手指上滑，取消发送"
        noteLabel.font = UIFont.systemFont(ofSize: 14)
        noteLabel.textColor = UIColor(hex: "81BAFE")
        noteLabel.layer.cornerRadius = 2.0
        noteLabel.layer.masksToBounds = true
        return noteLabel
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.initContent()
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
        self.initContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initContent() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        self.addSubview(self.tooShotPromptImageView)
        self.addSubview(self.cancelImageView)
        self.addSubview(self.noteLabel)
        
        self.addSubview(self.recordingView)
        self.recordingView.addSubview(self.voiceSignalImageView)
        self.recordingView.addSubview(self.signalValueImageView)
        
        noteLabel.snp.makeConstraints { (make) in
            make.left.equalTo(8)
            make.right.equalTo(-8)
            make.height.equalTo(20)
            make.bottom.equalTo(-6)
        }
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.recordingView.center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
    }

}

//对外交互的 view 控制
// MARK: - @extension CWVoiceIndicatorView
extension CWVoiceIndicatorView {
    //正在录音
    func recording() {
        self.isHidden = false
        self.cancelImageView.isHidden = true
        self.tooShotPromptImageView.isHidden = true
        self.recordingView.isHidden = false
        self.noteLabel.backgroundColor = UIColor.clear
        self.noteLabel.text = "手指上滑，取消发送"
    }
    
    //录音过程中音量的变化
    func signalValueChanged(_ value: CGFloat) {
        
    }
    
    //滑动取消
    func slideToCancelRecord() {
        self.isHidden = false
        self.cancelImageView.isHidden = false
        self.tooShotPromptImageView.isHidden = true
        self.recordingView.isHidden = true
        self.noteLabel.backgroundColor = UIColor(hex: "#9C3638")
        self.noteLabel.text = "松开手指，取消发送"
    }
    
    //录音时间太短的提示
    func messageTooShort() {
        self.isHidden = false
        self.cancelImageView.isHidden = true
        self.tooShotPromptImageView.isHidden = false
        self.recordingView.isHidden = true
        self.noteLabel.backgroundColor = UIColor.clear
        self.noteLabel.text = "说话时间太短"
        //0.5秒后消失
        let delayTime = DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.endRecord()
        }
    }
    
    //录音结束
    func endRecord() {
        self.isHidden = true
    }
    
    //更新麦克风的音量大小
    func updateMetersValue(_ value: Float) {
        var index = Int(round(value))
        index = index > 7 ? 7 : index
        index = index < 0 ? 0 : index
        
        let array = [
            CWAsset.RecordingSignal001.image,
            CWAsset.RecordingSignal002.image,
            CWAsset.RecordingSignal003.image,
            CWAsset.RecordingSignal004.image,
            CWAsset.RecordingSignal005.image,
            CWAsset.RecordingSignal006.image,
            CWAsset.RecordingSignal007.image,
            CWAsset.RecordingSignal008.image,
            ]
        
        self.signalValueImageView.image = array[index]
        
    }
}

