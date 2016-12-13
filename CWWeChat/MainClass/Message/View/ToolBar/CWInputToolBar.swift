//
//  CWInputToolBar.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/26.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/// toolBar代理事件
protocol CWInputToolBarDelegate: class {
    ///发送文字
    func chatInputView(_ inputView: CWInputToolBar, sendText text: String)
    ///发送图片
    func chatInputView(_ inputView: CWInputToolBar, sendImage imageName: String ,extentInfo:Dictionary<String,String>)
    
    /**
     发送录音
     
     - parameter chatToolBar: chatToolBar
     - parameter voicePath:   录音文件路径
     */
    func chatInputView(_ inputView: CWInputToolBar, sendVoice voicePath: String, recordTime: Float)
    
    
//    func chatInputView(inputView: CWInputToolBar, changeChatBarStatus fromstatus:CWChatBarStatus, toStatus:CWChatBarStatus)

}

class CWInputToolBar: UIView {

    weak var delegate: CWInputToolBarDelegate?
    weak var voiceIndicatorView: CWVoiceIndicatorView?
    /// 输入框
    var inputTextView:CWMessageTextView = {
        let inputTextView = CWMessageTextView(frame:CGRect.zero)
        inputTextView.returnKeyType = .send
        inputTextView.enablesReturnKeyAutomatically = true
        return inputTextView
    }()
    
    ///录音按钮
    lazy var voiceButton: UIButton =  {
        let voiceButton = UIButton(type: .custom)
        voiceButton.setNormalImage(self.kVoiceImage, highlighted:self.kVoiceImageHL)
        voiceButton.addTarget(self, action: #selector(CWInputToolBar.voiceButtonAction(_:)), for: .touchUpInside)
        voiceButton.tag = 100
        return voiceButton
    }()
    
    /// 表情按钮
    lazy var emotionButton: UIButton = {
        let emotionButton = UIButton(type: .custom)
        emotionButton.setNormalImage(self.kEmojiImage, highlighted:self.kEmojiImageHL)
        emotionButton.addTarget(self, action: #selector(CWInputToolBar.emotionButtonSelector(_:)), for: .touchDown)
        
        emotionButton.tag = 101
        return emotionButton
    }()
    
    ///更多按钮
    lazy var moreButton: UIButton = {
        let moreButton = UIButton(type: .custom)
        moreButton.tag = 102
        moreButton.autoresizingMask = [.flexibleLeftMargin]
        moreButton.setNormalImage(self.kMoreImage, highlighted:self.kMoreImageHL)
        moreButton.addTarget(self, action: #selector(CWInputToolBar.moreButtonSelector(_:)), for: .touchDown)
        return moreButton
    }()
    
    lazy var recordButton: UIButton = {
        let recordButton = UIButton(type: .custom)
        recordButton.setTitle("按住     说话", for: UIControlState())
        recordButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        recordButton.setBackgroundImage(UIImage.imageWithColor(UIColor("#F6F6F6")), for: .normal)
        recordButton.setTitleColor(UIColor.black, for: UIControlState())
        recordButton.layer.borderColor = UIColor("#DADADA").cgColor
        recordButton.layer.borderWidth = 1
        recordButton.layer.cornerRadius = 5.0
        recordButton.layer.masksToBounds = true
        recordButton.isHidden = true
        
        recordButton.addTarget(self, action: #selector(recordClick(_:)), for: .touchDown)
        recordButton.addTarget(self, action: #selector(recordComplection(_:)), for: .touchUpInside)
        recordButton.addTarget(self, action: #selector(recordDragOut(_:)), for: .touchDragOutside)
        recordButton.addTarget(self, action: #selector(recordDragIn(_:)), for: .touchDragInside)
                recordButton.addTarget(self, action: #selector(recordCancel(_:)), for: .touchUpOutside)
        
        return recordButton
    }()
    
    var record: CWVoiceRecorder?
    var status: CWChatBarStatus = .Init

    //按钮的图片
    var kVoiceImage:UIImage = CWAsset.ToolViewInputVoice.image
    var kVoiceImageHL:UIImage = CWAsset.ToolViewInputVoiceHL.image
    var kEmojiImage:UIImage = CWAsset.ToolViewEmotion.image
    var kEmojiImageHL:UIImage = CWAsset.ToolViewEmotionHL.image
    
    //图片名称待修改
    var kMoreImage:UIImage = CWAsset.TypeSelectorBtn_Black.image
    var kMoreImageHL:UIImage = CWAsset.TypeSelectorBtnHL_Black.image
    
    var kKeyboardImage:UIImage = CWAsset.ToolViewKeyboard.image
    var kKeyboardImageHL:UIImage = CWAsset.ToolViewKeyboardHL.image
    
    //MARK: 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.autoresizingMask = [UIViewAutoresizing.flexibleWidth,UIViewAutoresizing.flexibleTopMargin]
        self.isOpaque = true
        self.backgroundColor = UIColor.white
        
        addSubview(self.voiceButton)
        addSubview(self.emotionButton)
        addSubview(self.moreButton)
        addSubview(self.inputTextView)
        addSubview(self.recordButton)

        setupFrame()
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(0.5)
        context?.setStrokeColor(UIColor.gray.cgColor)
        
        context?.beginPath()
        context?.move(to: CGPoint(x: 0, y: 0))
        context?.addLine(to: CGPoint(x: Screen_Width, y: 0))
        context?.closePath()
        context?.strokePath()
    }
    
    func setupFrame() {
        
        // 需要显示按钮的总宽度，包括间隔在内
        var allButtonWidth:CGFloat = 0.0
        // 水平间隔
        let horizontalPadding:CGFloat = 8
        // 垂直间隔
        let verticalPadding:CGFloat = 5
        
        var textViewLeftMargin:CGFloat = 6.0
        
        var buttonFrame = CGRect.zero
        buttonFrame.size = CGSize(width: CWInputToolBar.textViewLineHeight(),
                                  height: CWInputToolBar.textViewLineHeight())
        //录音
        buttonFrame.origin = CGPoint(x: horizontalPadding, y: verticalPadding)
        voiceButton.frame = buttonFrame
        
        allButtonWidth += buttonFrame.right
        textViewLeftMargin += buttonFrame.right
        
        
        //更多
        buttonFrame.origin = CGPoint(x: Screen_Width-horizontalPadding-buttonFrame.width,
                                     y: verticalPadding)
        moreButton.frame = buttonFrame
        allButtonWidth += buttonFrame.width + 2.5*horizontalPadding
        //表情
        buttonFrame.origin = CGPoint(x: moreButton.frame.x-horizontalPadding-buttonFrame.width,
                                     y: verticalPadding)
        emotionButton.frame = buttonFrame
        allButtonWidth += buttonFrame.width + 1.5*horizontalPadding
        //
        //输入框高度
        let width = self.bounds.width - allButtonWidth;
        let height = CWInputToolBar.textViewLineHeight()
        inputTextView.frame = CGRect(x: textViewLeftMargin, y: 4.5, width: width, height: height)
        inputTextView.delegate = self
        
        recordButton.frame = inputTextView.frame
    }
    
    
    // MARK: 按钮点击事件
    func emotionButtonSelector(_ button: UIButton) {

    }
    
    func moreButtonSelector(_ button: UIButton) {
        let pickerVC = UIImagePickerController()
        pickerVC.sourceType = .photoLibrary
        pickerVC.delegate = self
        if let viewcontroller = UIApplication.shared.keyWindow?.rootViewController {
            viewcontroller.present(pickerVC, animated: true, completion: nil)
        }
    }
    
    func voiceButtonAction(_ button: UIButton) {
    
        
        if self.status == .voice {
            
            if let _ = self.delegate {
//                delegate.chatInputView(self, changeChatBarStatus: self.status, toStatus: .Keyboard)
            }
            
            self.inputTextView.becomeFirstResponder()
            self.inputTextView.isHidden = false
            self.recordButton.isHidden = true
            
            self.status = .keyboard
            voiceButton.setNormalImage(self.kVoiceImage, highlighted:self.kVoiceImageHL)
            
        } else {
            
            if let _ = self.delegate {
                //            delegate.chatInputView(self, changeChatBarStatus: self.status, toStatus: .Voice)
            }
            
            if self.status == .keyboard {
                self.inputTextView.resignFirstResponder()
            }
            
            self.inputTextView.isHidden = true
            self.recordButton.isHidden = false
            
            self.status = .voice
            voiceButton.setNormalImage(self.kKeyboardImage, highlighted:self.kKeyboardImageHL)
            
        }
        

    
    }

    //MARK: 录音相关的
    func recordCancel(_ button: UIButton) {
        record!.cancelRecord()
    }

    func recordComplection(_ button: UIButton) {
        record?.stopRecord()
    }
    
    func recordDragOut(_ button: UIButton) {
        print("recordDragOut")
    }
    
    func recordDragIn(_ button: UIButton) {
        print("recordDragIn")
    }
    
    ///录音按钮按下
    func recordClick(_ button: UIButton) {
        record = CWVoiceRecorder()
        record?.delegate = self
        record?.startRecord()
    }
    
    
    //MARK: 计算高度
    class func textViewLineHeight() -> CGFloat {
        return 36.0
    }
    
    class func maxLines() -> CGFloat {
        return 3.0
    }
    
    class func maxHeight() -> CGFloat {
        return ((self.maxLines() + 1.0) * self.textViewLineHeight());
    }
    
}

extension CWInputToolBar: CWVoiceRecorderDelegate {
    
    func audioRecordUpdateMetra(_ metra: Float) {
        print("11111\(metra)")
        voiceIndicatorView?.recording()
        voiceIndicatorView?.updateMetersValue(metra)
    }
    
    func audioRecordFinish(_ filename: String, recordTime: Float) {
        if let delegate = self.delegate {
            delegate.chatInputView(self, sendVoice: filename, recordTime: recordTime)
        }
    }
}

// MARK: - UITextViewDelegate
extension CWInputToolBar: UITextViewDelegate {

    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            sendCurrentTextViewText()
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        
    }
    
    ///发送文字
    func sendCurrentTextViewText() {
        guard self.inputTextView.text.characters.count > 0 else {
            return
        }
        
        if let delegate = self.delegate {
            delegate.chatInputView(self, sendText: self.inputTextView.text)
        }
        //还有待修改
        self.inputTextView.text = ""
    }

}

// 暂时的，需要修改。
extension CWInputToolBar:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imagename = "\(String.UUIDString())"
        let path = CWUserAccount.sharedUserAccount().pathUserChatImage(imagename)
        FileManager.saveContentImage(image, imagePath: path)
        if let delegate = self.delegate {
            delegate.chatInputView(self, sendImage: imagename, extentInfo:["size":NSStringFromCGSize(image.size)])
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func video(_ videoPath: String, didFinishSavingWithError error: NSError, contextInfo info: UnsafeMutableRawPointer) {
        print("保存成功")
    }
}

