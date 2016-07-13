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
    
    var cancelImageView: UIImageView!  //取消提示
    var signalValueImageView: UIImageView!   //音量的图片
    var recordingView: UIView!  //录音整体的 view，控制是否隐藏
    var tooShotPromptImageView: UIImageView!  //录音时间太短的提示
    
     //中央的灰色背景 view
    var centerView: UIView! {
        didSet {
            centerView.layer.cornerRadius = 4.0
            centerView.layer.masksToBounds = true
        }
    }
    
    //提示的 label
    var noteLabel: UILabel! {
        didSet {
            noteLabel.layer.cornerRadius = 2.0
            noteLabel.layer.masksToBounds = true
        }
    }
    
    override init (frame : CGRect) {
        super.init(frame : frame)
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
        
    }

}

//对外交互的 view 控制
// MARK: - @extension TSChatVoiceIndicatorView
extension CWVoiceIndicatorView {
    //正在录音
    func recording() {
        self.hidden = false
        self.cancelImageView.hidden = true
        self.tooShotPromptImageView.hidden = true
        self.recordingView.hidden = false
        self.noteLabel.backgroundColor = UIColor.clearColor()
        self.noteLabel.text = "手指上滑，取消发送"
    }
    
    //录音过程中音量的变化
    func signalValueChanged(value: CGFloat) {
        
    }
    
    //滑动取消
    func slideToCancelRecord() {
        self.hidden = false
        self.cancelImageView.hidden = false
        self.tooShotPromptImageView.hidden = true
        self.recordingView.hidden = true
        self.noteLabel.backgroundColor = UIColor(hexString: "#9C3638")
        self.noteLabel.text = "松开手指，取消发送"
    }
    
    //录音时间太短的提示
    func messageTooShort() {
        self.hidden = false
        self.cancelImageView.hidden = true
        self.tooShotPromptImageView.hidden = false
        self.recordingView.hidden = true
        self.noteLabel.backgroundColor = UIColor.clearColor()
        self.noteLabel.text = "说话时间太短"
        //0.5秒后消失
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.endRecord()
        }
    }
    
    //录音结束
    func endRecord() {
        self.hidden = true
    }
    
    //更新麦克风的音量大小
    func updateMetersValue(value: Float) {
        var index = Int(round(value))
        index = index > 7 ? 7 : index
        index = index < 0 ? 0 : index
        
//        let array = [
//            TSAsset.RecordingSignal001.image,
//            TSAsset.RecordingSignal002.image,
//            TSAsset.RecordingSignal003.image,
//            TSAsset.RecordingSignal004.image,
//            TSAsset.RecordingSignal005.image,
//            TSAsset.RecordingSignal006.image,
//            TSAsset.RecordingSignal007.image,
//            TSAsset.RecordingSignal008.image,
//            ]
//        self.signalValueImageView.image = array.get(index)
        
    }
}

