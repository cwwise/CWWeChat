//
//  ToolView.swift
//  Keyboard
//
//  Created by chenwei on 2017/7/20.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

enum ToolViewStatus {
    case none
    case text
    case audio
    case emoticon
    case more
}

private let kItemSpacing: CGFloat = 3
private let kTextViewPadding: CGFloat = 6

protocol ToolViewDelegate: class {
    
    func textViewShouldBeginEditing()
    
}

/// 输入框按钮
class ToolView: UIView {

    weak var delegate: ToolViewDelegate?
    // MARK: 属性
    var contentText: String? {
        didSet {
            inputTextView.text = contentText
        }
    }
    
    var showsKeyboard: Bool {
        get {
            return inputTextView.isFirstResponder
        }
        set {
            if newValue {
                inputTextView.becomeFirstResponder()
            } else {
                inputTextView.resignFirstResponder()
            }
        }
    }
    
    var status: ToolViewStatus = .none
    
    /// 输入框
    lazy var inputTextView: InputTextView = {
        let inputTextView = InputTextView(frame:CGRect.zero)
        inputTextView.delegate = self
        return inputTextView
    }()
    
    /// 表情按钮
    lazy var emoticonButton: UIButton = {
        let emoticonButton = UIButton(type: .custom)
        emoticonButton.autoresizingMask = [.flexibleTopMargin]
        emoticonButton.setNormalImage(self.kEmojiImage, highlighted:self.kEmojiImageHL)
        
        return emoticonButton
    }()
    
    /// 文字和录音切换
    lazy var voiceButton: UIButton =  {
        let voiceButton = UIButton(type: .custom)
        voiceButton.autoresizingMask = [.flexibleTopMargin]
        
        voiceButton.setNormalImage(self.kVoiceImage, highlighted:self.kVoiceImageHL)
        return voiceButton
    }()
    
    ///更多按钮
    lazy var moreButton: UIButton = {
        let moreButton = UIButton(type: .custom)
        moreButton.autoresizingMask = [.flexibleTopMargin]
        moreButton.setNormalImage(self.kMoreImage, highlighted:self.kMoreImageHL)
        return moreButton
    }()
    
    /// 录音按钮
    lazy var recordButton: RecordButton = {
        let recordButton = RecordButton(frame: CGRect.zero)
        return recordButton
    }()
    
    //按钮的图片
    var kVoiceImage:UIImage = UIImage(named: "chat_toolbar_voice")!
    var kVoiceImageHL:UIImage = UIImage(named: "chat_toolbar_voice_HL")!
    var kEmojiImage:UIImage = UIImage(named: "chat_toolbar_emotion")!
    var kEmojiImageHL:UIImage = UIImage(named: "chat_toolbar_emotion_HL")!
    
    //图片名称待修改
    var kMoreImage:UIImage = UIImage(named: "chat_toolbar_more")!
    var kMoreImageHL:UIImage = UIImage(named: "chat_toolbar_more_HL")!
    
    var kKeyboardImage:UIImage = UIImage(named: "chat_toolbar_keyboard")!
    var kKeyboardImageHL:UIImage = UIImage(named: "chat_toolbar_keyboard_HL")!
    
    var allowVoice: Bool = true
    var allowFaceView: Bool = true
    var allowMoreView: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        
        self.autoresizingMask = [UIViewAutoresizing.flexibleWidth,UIViewAutoresizing.flexibleTopMargin]
        self.backgroundColor = UIColor(hex: "#E4EBF0")
        
        addSubview(self.voiceButton)
        addSubview(self.emoticonButton)
        addSubview(self.moreButton)
        addSubview(self.recordButton)
        addSubview(self.inputTextView)
        
        // 分割线
        let line = UIView()
        line.backgroundColor = UIColor(hex: "#e9e9e9")
        line.frame = CGRect(x: 0, y: self.frame.height-1, width: self.frame.width, height: 1.0/UIScreen.main.scale)
        addSubview(line)
        
        let toolBarHeight = self.height
        
        let kItem: CGFloat = 42
        let buttonSize = CGSize(width: kItem, height: 49)
        
        if self.allowVoice {
            let origin = CGPoint(x: 0, y: toolBarHeight-buttonSize.height)
            voiceButton.frame = CGRect(origin: origin, size: buttonSize)
        } else {
            voiceButton.frame = CGRect.zero
        }
        
        if self.allowMoreView {
            let origin = CGPoint(x: self.bounds.width-buttonSize.width, y: toolBarHeight-buttonSize.height)
            moreButton.frame = CGRect(origin: origin, size: buttonSize)
        } else {
            moreButton.frame = CGRect.zero
        }
        
        if self.allowFaceView {
            let origin = CGPoint(x: self.bounds.width-buttonSize.width*2, y: toolBarHeight-buttonSize.height)
            emoticonButton.frame = CGRect(origin: origin, size: buttonSize)
        } else {
            emoticonButton.frame = CGRect.zero
        }
        
        var textViewX = voiceButton.right
        var textViewWidth = emoticonButton.left - voiceButton.right
        
        if textViewX == 0 {
            textViewX = 8
            textViewWidth -= textViewX
        }
        
        let height: CGFloat = 36
        inputTextView.frame = CGRect(x: textViewX, y: (49 - height)/2.0,
                                     width: textViewWidth, height: height)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateStatus(_ status: ToolViewStatus) {
        
        if status == .text || status == .more {
            
            self.recordButton.isHidden = true
            self.inputTextView.isHidden = false
            updateVoiceButtonImage(true)
            updateEmoticonButtonImage(true)

        } else if (status == .audio) {
            self.recordButton.isHidden = false
            self.inputTextView.isHidden = true
            
            updateVoiceButtonImage(false)
            updateEmoticonButtonImage(true)
        } else if (status == .emoticon) {
            
            self.recordButton.isHidden = true
            self.inputTextView.isHidden = false
            updateVoiceButtonImage(true)
            updateEmoticonButtonImage(true)
        }
        
        
    }
    
    
    func updateVoiceButtonImage(_ selected: Bool) {
        self.voiceButton.setImage(selected ? kVoiceImage:kKeyboardImage, for: .normal)
        self.voiceButton.setImage(selected ? kVoiceImageHL:kKeyboardImageHL, for: .highlighted)
    }
    
    func updateEmoticonButtonImage(_ selected: Bool) {
        self.emoticonButton.setImage(selected ? kEmojiImage:kKeyboardImage, for: .normal)
        self.emoticonButton.setImage(selected ? kEmojiImageHL:kKeyboardImageHL, for: .highlighted)
    }

}



extension ToolView : UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.delegate?.textViewShouldBeginEditing()
        return true
    }
    
}




