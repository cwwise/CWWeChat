//
//  CWInputToolBar.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/1.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/// toolBar代理事件
public protocol CWInputToolBarDelegate: class {
    ///发送文字
    func chatInputView(_ inputView: CWInputToolBar, sendText text: String)
    ///发送图片
    func chatInputView(_ inputView: CWInputToolBar, image: UIImage)
}

public class CWInputToolBar: UIView {

    var status: CWToolBarStatus = .initial 
    weak var delegate: CWInputToolBarDelegate?
    /// 临时记录输入的textView
    var currentText: String?
    var previousTextViewHeight: CGFloat = 36
    
    //MARK: 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    func setupUI() {
        self.autoresizingMask = [UIViewAutoresizing.flexibleWidth,UIViewAutoresizing.flexibleTopMargin]
        self.isOpaque = true
        self.backgroundColor = UIColor.white
        
        addSubview(self.voiceButton)
        addSubview(self.emotionButton)
        addSubview(self.moreButton)
        addSubview(self.recordButton)
        addSubview(self.inputTextView)
        
        setupFrame()
        self.kvoController.observe(self.inputTextView, keyPath: "contentSize", options: .new, action: #selector(layoutAndAnimateTextView))
    }
    
    func setupFrame() {
        
        // 需要显示按钮的总宽度，包括间隔在内
        var allButtonWidth:CGFloat = 0.0
        // 水平间隔
        let horizontalPadding:CGFloat = 8
        // 垂直间隔
        let verticalPadding:CGFloat = 5
        // 
        var textViewLeftMargin:CGFloat = 6.0
        
        var buttonFrame = CGRect.zero
        buttonFrame.size = CGSize(width: self.textViewLineHeight(),
                                  height: self.textViewLineHeight())
        //录音
        buttonFrame.origin = CGPoint(x: horizontalPadding, y: verticalPadding)
        voiceButton.frame = buttonFrame
        
        allButtonWidth += buttonFrame.right
        textViewLeftMargin += buttonFrame.right
        
        
        //更多
        buttonFrame.origin = CGPoint(x: kScreenWidth-horizontalPadding-buttonFrame.width,
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
        let height = self.textViewLineHeight()
        inputTextView.frame = CGRect(x: textViewLeftMargin, y: 4.5, width: width, height: height)
        recordButton.frame = inputTextView.frame
    }
    
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(0.5)
        context?.setStrokeColor(UIColor.gray.cgColor)
        
        context?.beginPath()
        context?.move(to: CGPoint(x: 0, y: 0))
        context?.addLine(to: CGPoint(x: kScreenWidth, y: 0))
        context?.closePath()
        context?.strokePath()
    }
    
    func textViewContent(_ content: String) {
        self.currentText = content
        self.inputTextView.text = content
    }
    
    func clearTextViewContent() {
        self.currentText = ""
        self.inputTextView.text = ""
    }
    
    // MARK: 属性
    /// 输入框
    lazy var inputTextView: CWInputTextView = {
        let inputTextView = CWInputTextView(frame:CGRect.zero)
        inputTextView.delegate = self
        return inputTextView
    }()

    /// 表情按钮
    lazy var emotionButton: UIButton = {
        let emotionButton = UIButton(type: .custom)
        emotionButton.autoresizingMask = [.flexibleTopMargin]

        emotionButton.setNormalImage(self.kEmojiImage, highlighted:self.kEmojiImageHL)        
        emotionButton.tag = CWToolBarStatus.emoji.rawValue
        emotionButton.addTarget(self, action: #selector(toolButtonSelector(_:)), for: .touchDown)
        return emotionButton
    }()
    
    /// 文字和录音切换
    lazy var voiceButton: UIButton =  {
        let voiceButton = UIButton(type: .custom)
        voiceButton.autoresizingMask = [.flexibleTopMargin]

        voiceButton.setNormalImage(self.kVoiceImage, highlighted:self.kVoiceImageHL)
        voiceButton.tag = CWToolBarStatus.voice.rawValue
        voiceButton.addTarget(self, action: #selector(toolButtonSelector(_:)), for: .touchDown)
        return voiceButton
    }()
    
    /// 录音按钮
    lazy var recordButton: CWRecordButton = {
        let recordButton = CWRecordButton(frame: CGRect.zero)
        recordButton.tag = 103
        return recordButton
    }()
    
    ///更多按钮
    lazy var moreButton: UIButton = {
        let moreButton = UIButton(type: .custom)
        moreButton.tag = CWToolBarStatus.more.rawValue
        moreButton.autoresizingMask = [.flexibleTopMargin]
        moreButton.setNormalImage(self.kMoreImage, highlighted:self.kMoreImageHL)
        moreButton.addTarget(self, action: #selector(toolButtonSelector(_:)), for: .touchDown)
        return moreButton
    }()
    
    
    //按钮的图片
    var kVoiceImage:UIImage = CWAsset.Chat_toolbar_voice.image
    var kVoiceImageHL:UIImage = CWAsset.Chat_toolbar_voice_HL.image
    var kEmojiImage:UIImage = CWAsset.Chat_toolbar_emotion.image
    var kEmojiImageHL:UIImage = CWAsset.Chat_toolbar_emotion_HL.image
    
    //图片名称待修改
    var kMoreImage:UIImage = CWAsset.Chat_toolbar_more.image
    var kMoreImageHL:UIImage = CWAsset.Chat_toolbar_more_HL.image
    
    var kKeyboardImage:UIImage = CWAsset.Chat_toolbar_keyboard.image
    var kKeyboardImageHL:UIImage = CWAsset.Chat_toolbar_keyboard_HL.image
    
    
    func beginInputing() {
        self.inputTextView.becomeFirstResponder()
    }
    
    func endInputing() {
        if voiceButton.isSelected {
            return
        }
        voiceButton.isSelected = false
        emotionButton.isSelected = false
        moreButton.isSelected = false
        updateToolStatus(.initial)
    }
    
    //MARK: Action
    func toolButtonSelector(_ button: UIButton) {
        // 加个判断
        var selectStatus = CWToolBarStatus(rawValue: button.tag)!
        
        if button == emotionButton {
            emotionButton.isSelected = !emotionButton.isSelected
            moreButton.isSelected = false
            voiceButton.isSelected = false
        } else if button == moreButton {
            
            let pickerVC = UIImagePickerController()
            pickerVC.sourceType = .photoLibrary
            pickerVC.delegate = self
            if let viewcontroller = UIApplication.shared.keyWindow?.rootViewController {
                viewcontroller.present(pickerVC, animated: true, completion: nil)
            }
            
            
            emotionButton.isSelected = false
            moreButton.isSelected = !moreButton.isSelected
            voiceButton.isSelected = false
        } else if button == voiceButton {
            emotionButton.isSelected = false
            moreButton.isSelected = false
            voiceButton.isSelected = !voiceButton.isSelected
        }
        
        if button.isSelected == false {
            selectStatus = .keyboard
            beginInputing()
        }
        updateToolStatus(selectStatus)
    }
    
    func updateToolStatus(_ status: CWToolBarStatus?) {
        guard let status = status, status != self.status else {
            return
        }
        self.status = status
        
        switch status {
        case .initial:
            resumeTextViewContentSize()
            self.inputTextView.resignFirstResponder()
        case .voice:
            adjustTextViewContentSize()
            self.inputTextView.resignFirstResponder()
        case .more,.emoji:
            adjustTextViewContentSize()
            self.inputTextView.resignFirstResponder()
        case .keyboard:
            resumeTextViewContentSize()
        }
        
    }
    
    
    // MARK: 
    func showVoiceView(_ show: Bool) {
        
        self.voiceButton.isSelected = show
        self.recordButton.isSelected = show
        self.recordButton.isHidden = !show
        
        self.inputTextView.isHidden = !self.recordButton.isHidden
    }
    
    // MARK: 功能
    func resumeTextViewContentSize() {
        self.inputTextView.text = self.currentText
    }
    
    func adjustTextViewContentSize() {
        self.currentText = self.inputTextView.text
        self.inputTextView.text = ""
        
        inputTextView.contentSize = CGSize(width: inputTextView.width,
                                           height: self.textViewLineHeight())
    }
    
    // MARK: 高度变化
    func layoutAndAnimateTextView() {
        
        let maxHeight = self.textViewLineHeight() * 5
        let contentHeight = ceil(inputTextView.sizeThatFits(inputTextView.size).height)
    
        let isShrinking = contentHeight < self.previousTextViewHeight
        var changeInHeight = contentHeight - self.previousTextViewHeight
        
        let result = self.previousTextViewHeight == maxHeight || inputTextView.text.characters.count == 0
        if !isShrinking && result {
            changeInHeight = 0
        } else {
            changeInHeight = min(changeInHeight, maxHeight-self.previousTextViewHeight)
        }
        if changeInHeight != 0 {
            
            UIView.animate(withDuration: 0.25, animations: { 
                
                if !isShrinking {
                    self.adjustTextViewHeightBy(changeInHeight)
                }
                
                let inputViewFrame = self.frame
                self.frame = CGRect(x: 0, 
                                    y: inputViewFrame.y - changeInHeight,
                                    width: inputViewFrame.width,
                                    height: inputViewFrame.height + changeInHeight)
                
                if isShrinking {
                    self.adjustTextViewHeightBy(changeInHeight)
                }
            })
            self.previousTextViewHeight = min(contentHeight, maxHeight)
        }
        
        if self.previousTextViewHeight == maxHeight {

            DispatchQueueDelay(0.01, task: { 
                let bottomOffset = CGPoint(x: 0.0, y: contentHeight - self.inputTextView.bounds.height)
                self.inputTextView.setContentOffset(bottomOffset, animated: true)
            
            })
            
        }
        
    }
    
    func adjustTextViewHeightBy(_ changeInHeight: CGFloat) {
        
        let prevFrame = self.inputTextView.frame
//        let numLines = self.inputTextView.numberOfLinesOfText()
        self.inputTextView.frame = CGRect(x: prevFrame.x, 
                                          y: prevFrame.y,
                                          width: prevFrame.width, 
                                          height: prevFrame.height + changeInHeight)
        self.inputTextView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    //MARK: 计算高度
    func textViewLineHeight() -> CGFloat {
        return 36.0
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

// MARK: - UITextViewDelegate
extension CWInputToolBar: UITextViewDelegate {
    // 开始编辑的时候
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        voiceButton.isSelected = false
        emotionButton.isSelected = false
        moreButton.isSelected = false
        return true
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            sendCurrentTextViewText()
            return false
        }
        return true
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        self.currentText = textView.text
        
    }
    
    ///发送文字
    func sendCurrentTextViewText() {
        guard self.inputTextView.text.characters.count > 0 else {
            return
        }
        
        delegate?.chatInputView(self, sendText: self.inputTextView.text)
        //还有待修改
        self.inputTextView.text = ""
    }
    
}


// 暂时的，需要修改。
extension CWInputToolBar:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.delegate?.chatInputView(self, image: image)
        picker.dismiss(animated: true, completion: nil)
    }
    
}
