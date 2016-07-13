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
    func chatInputView(inputView: CWInputToolBar, sendText text: String)
    ///发送图片
    func chatInputView(inputView: CWInputToolBar, sendImage imageName: String ,extentInfo:Dictionary<String,String>)
    
    /**
     发送录音
     
     - parameter chatToolBar: chatToolBar
     - parameter voicePath:   录音文件路径
     */
    func chatInputView(inputView: CWInputToolBar, sendVoice voicePath: String, recordTime: Float)
    
    
//    func chatInputView(inputView: CWInputToolBar, changeChatBarStatus fromstatus:CWChatBarStatus, toStatus:CWChatBarStatus)

}

class CWInputToolBar: UIView {

    weak var delegate: CWInputToolBarDelegate?
    weak var voiceIndicatorView: CWVoiceIndicatorView?
    /// 输入框
    var inputTextView:CWMessageTextView = {
        let inputTextView = CWMessageTextView(frame:CGRectZero)
        inputTextView.returnKeyType = .Send
        inputTextView.enablesReturnKeyAutomatically = true
        return inputTextView
    }()
    
    ///录音按钮
    lazy var voiceButton: UIButton =  {
        let voiceButton = UIButton(type: .Custom)
        voiceButton.setNormalImage(self.kVoiceImage, highlighted:self.kVoiceImageHL)
        voiceButton.addTarget(self, action: #selector(CWInputToolBar.voiceButtonAction(_:)), forControlEvents: .TouchUpInside)
        voiceButton.tag = 100
        return voiceButton
    }()
    
    /// 表情按钮
    lazy var emotionButton: UIButton = {
        let emotionButton = UIButton(type: .Custom)
        emotionButton.setNormalImage(self.kEmojiImage, highlighted:self.kEmojiImageHL)
        emotionButton.addTarget(self, action: #selector(CWInputToolBar.emotionButtonSelector(_:)), forControlEvents: .TouchDown)
        
        emotionButton.tag = 101
        return emotionButton
    }()
    
    ///更多按钮
    lazy var moreButton: UIButton = {
        let moreButton = UIButton(type: .Custom)
        moreButton.tag = 102
        moreButton.autoresizingMask = [.FlexibleLeftMargin]
        moreButton.setNormalImage(self.kMoreImage, highlighted:self.kMoreImageHL)
        moreButton.addTarget(self, action: #selector(CWInputToolBar.moreButtonSelector(_:)), forControlEvents: .TouchDown)
        return moreButton
    }()
    
    lazy var recordButton: UIButton = {
        let recordButton = UIButton(type: .Custom)
        recordButton.setTitle("按住     说话", forState: .Normal)
        recordButton.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        recordButton.setBackgroundImage(UIImage.imageWithColor(UIColor(hexString: "#F6F6F6")), forState: .Normal)
        recordButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        recordButton.layer.borderColor = UIColor(hexString: "#DADADA").CGColor
        recordButton.layer.borderWidth = 1
        recordButton.layer.cornerRadius = 5.0
        recordButton.layer.masksToBounds = true
        recordButton.hidden = true
        
        recordButton.addTarget(self, action: #selector(recordClick(_:)), forControlEvents: .TouchDown)
        recordButton.addTarget(self, action: #selector(recordComplection(_:)), forControlEvents: .TouchUpInside)
        recordButton.addTarget(self, action: #selector(recordDragOut(_:)), forControlEvents: .TouchDragOutside)
        recordButton.addTarget(self, action: #selector(recordDragIn(_:)), forControlEvents: .TouchDragInside)
                recordButton.addTarget(self, action: #selector(recordCancel(_:)), forControlEvents: .TouchUpOutside)
        
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
        self.autoresizingMask = [UIViewAutoresizing.FlexibleWidth,UIViewAutoresizing.FlexibleTopMargin]
        self.opaque = true
        self.backgroundColor = UIColor.whiteColor()
        
        addSubview(self.voiceButton)
        addSubview(self.emotionButton)
        addSubview(self.moreButton)
        addSubview(self.inputTextView)
        addSubview(self.recordButton)

        setupFrame()
    }
    
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 0.5)
        CGContextSetStrokeColorWithColor(context, UIColor.grayColor().CGColor)
        
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, 0, 0)
        CGContextAddLineToPoint(context, Screen_Width, 0)
        CGContextClosePath(context)
        CGContextStrokePath(context)
    }
    
    func setupFrame() {
        
        // 需要显示按钮的总宽度，包括间隔在内
        var allButtonWidth:CGFloat = 0.0
        // 水平间隔
        let horizontalPadding:CGFloat = 8
        // 垂直间隔
        let verticalPadding:CGFloat = 5
        
        var textViewLeftMargin:CGFloat = 6.0
        
        var buttonFrame = CGRectZero
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
        let width = CGRectGetWidth(self.bounds) - allButtonWidth;
        let height = CWInputToolBar.textViewLineHeight()
        inputTextView.frame = CGRect(x: textViewLeftMargin, y: 4.5, width: width, height: height)
        inputTextView.delegate = self
        
        recordButton.frame = inputTextView.frame
    }
    
    
    // MARK: 按钮点击事件
    func emotionButtonSelector(button: UIButton) {

    }
    
    func moreButtonSelector(button: UIButton) {
        let pickerVC = UIImagePickerController()
        pickerVC.sourceType = .PhotoLibrary
        pickerVC.delegate = self
        if let viewcontroller = UIApplication.sharedApplication().keyWindow?.rootViewController {
            viewcontroller.presentViewController(pickerVC, animated: true, completion: nil)
        }
    }
    
    func voiceButtonAction(button: UIButton) {
    
        
        if self.status == .Voice {
            
            if let delegate = self.delegate {
//                delegate.chatInputView(self, changeChatBarStatus: self.status, toStatus: .Keyboard)
            }
            
            self.inputTextView.becomeFirstResponder()
            self.inputTextView.hidden = false
            self.recordButton.hidden = true
            
            self.status = .Keyboard
            voiceButton.setNormalImage(self.kVoiceImage, highlighted:self.kVoiceImageHL)
            
        } else {
            
            if let delegate = self.delegate {
                //            delegate.chatInputView(self, changeChatBarStatus: self.status, toStatus: .Voice)
            }
            
            if self.status == .Keyboard {
                self.inputTextView.resignFirstResponder()
            }
            
            self.inputTextView.hidden = true
            self.recordButton.hidden = false
            
            self.status = .Voice
            voiceButton.setNormalImage(self.kKeyboardImage, highlighted:self.kKeyboardImageHL)
            
        }
        

    
    }

    //MARK: 录音相关的
    func recordCancel(button: UIButton) {
        record!.cancelRecord()
    }

    func recordComplection(button: UIButton) {
        record?.stopRecord()
    }
    
    func recordDragOut(button: UIButton) {
        print("recordDragOut")
    }
    
    func recordDragIn(button: UIButton) {
        print("recordDragIn")
    }
    
    ///录音按钮按下
    func recordClick(button: UIButton) {
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
    
    func audioRecordUpdateMetra(metra: Float) {
        print("11111\(metra)")
        voiceIndicatorView?.recording()
        voiceIndicatorView?.updateMetersValue(metra)
    }
    
    func audioRecordFinish(filename: String, recordTime: Float) {
        if let delegate = self.delegate {
            delegate.chatInputView(self, sendVoice: filename, recordTime: recordTime)
        }
    }
}

// MARK: - UITextViewDelegate
extension CWInputToolBar: UITextViewDelegate {

    func textViewDidEndEditing(textView: UITextView) {
        textView.resignFirstResponder()
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            sendCurrentTextViewText()
            return false
        }
        return true
    }
    
    func textViewDidChange(textView: UITextView) {
        
        
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
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imagename = "\(String.UUIDString())"
        let path = CWUserAccount.sharedUserAccount().pathUserChatImage(imagename)
        NSFileManager.saveContentImage(image, imagePath: path)
        if let delegate = self.delegate {
            delegate.chatInputView(self, sendImage: imagename, extentInfo:["size":NSStringFromCGSize(image.size)])
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func video(videoPath: String, didFinishSavingWithError error: NSError, contextInfo info: UnsafeMutablePointer<Void>) {
        print("保存成功")
    }
}

