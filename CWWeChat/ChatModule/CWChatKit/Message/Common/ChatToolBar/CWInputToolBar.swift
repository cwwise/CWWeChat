//
//  CWInputToolBar.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/1.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/// toolBar代理事件
protocol CWInputToolBarDelegate: class {
    ///发送文字
    func chatInputView(_ inputView: CWInputToolBar, sendText text: String)
    ///发送图片
    func chatInputView(_ inputView: CWInputToolBar, image: UIImage)
}

class CWInputToolBar: UIView {

    weak var delegate: CWInputToolBarDelegate?
    /// 临时记录输入的textView
    var currentText: String?
    
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
        addSubview(self.inputTextView)
        
        setupFrame()
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
        buttonFrame.size = CGSize(width: CWInputToolBar.textViewLineHeight(),
                                  height: CWInputToolBar.textViewLineHeight())
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
        let height = CWInputToolBar.textViewLineHeight()
        inputTextView.frame = CGRect(x: textViewLeftMargin, y: 4.5, width: width, height: height)
        
    }
    
    
    override func draw(_ rect: CGRect) {
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
    
    /// 输入框
    lazy var inputTextView: UITextView = {
        let inputTextView = UITextView(frame:CGRect.zero)
        inputTextView.returnKeyType = .send
        inputTextView.font = UIFont.systemFont(ofSize: 16)
        inputTextView.layer.borderWidth = 0.5
        inputTextView.layer.borderColor = UIColor.gray.cgColor
        inputTextView.layer.cornerRadius = 4
        inputTextView.enablesReturnKeyAutomatically = true
        inputTextView.delegate = self
        return inputTextView
    }()

    /// 表情按钮
    lazy var emotionButton: UIButton = {
        let emotionButton = UIButton(type: .custom)
        emotionButton.setNormalImage(self.kEmojiImage, highlighted:self.kEmojiImageHL)        
        emotionButton.tag = 101
        return emotionButton
    }()
    
    ///录音按钮
    lazy var voiceButton: UIButton =  {
        let voiceButton = UIButton(type: .custom)
        voiceButton.setNormalImage(self.kVoiceImage, highlighted:self.kVoiceImageHL)
        voiceButton.tag = 100
        return voiceButton
    }()
    
    ///更多按钮
    lazy var moreButton: UIButton = {
        let moreButton = UIButton(type: .custom)
        moreButton.tag = 102
        moreButton.autoresizingMask = [.flexibleLeftMargin]
        moreButton.setNormalImage(self.kMoreImage, highlighted:self.kMoreImageHL)
        moreButton.addTarget(self, action: #selector(moreButtonSelector(_:)), for: .touchDown)
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
    
    
    //MARK: Action
    func moreButtonSelector(_ button: UIButton) {
        let pickerVC = UIImagePickerController()
        pickerVC.sourceType = .photoLibrary
        pickerVC.delegate = self
        if let viewcontroller = UIApplication.shared.keyWindow?.rootViewController {
            viewcontroller.present(pickerVC, animated: true, completion: nil)
        }
    }
    
    
    
    
    //MARK: 计算高度
    class func textViewLineHeight() -> CGFloat {
        return 36.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        delegate?.chatInputView(self, sendText: self.inputTextView.text)
        
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
        self.delegate?.chatInputView(self, image: image)
        picker.dismiss(animated: true, completion: nil)
    }
    
}
