//
//  MessageLayout.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/13.
//

import UIKit
import ChatClient

class MessageViewLayout: UICollectionViewFlowLayout {

    weak var delegate: MessageViewLayoutDelegate?
    
    var setting = MessageLayoutSettings()
    
    private var itemWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.frame.width - sectionInset.left - sectionInset.right
    }
    
    open override class var layoutAttributesClass: AnyClass {
        return MessageLayoutAttributes.self
    }
    
    
    override init() {
        super.init()
        sectionInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Attributes
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let attributesArray = super.layoutAttributesForElements(in: rect) as? [MessageLayoutAttributes] else { 
            return nil
        }
        
        attributesArray.forEach { attributes in
            if attributes.representedElementCategory == .cell {
               // configure(attributes: attributes)
            }
        }
        
        return attributesArray
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let attributes = super.layoutAttributesForItem(at: indexPath) as? MessageLayoutAttributes else { return nil }
        
        if attributes.representedElementCategory == UICollectionElementCategory.cell {
            //configure(attributes: attributes)
        }
        
        return attributes
    }
    
    
    // MARK: - Invalidation Context
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        
        return collectionView?.bounds.width != newBounds.width || collectionView?.bounds.height != newBounds.height
        
    }
    
    open override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds)
        guard let flowLayoutContext = context as? UICollectionViewFlowLayoutInvalidationContext else { return context }
        flowLayoutContext.invalidateFlowLayoutDelegateMetrics = shouldInvalidateLayout(forBoundsChange: newBounds)
        return flowLayoutContext
    }

}

extension MessageViewLayout {
    
    private func configure(attributes: MessageLayoutAttributes) {
        
        guard let collectionView = collectionView,
            let message = delegate?.collectionView(collectionView, itemAt: attributes.indexPath) else {
                return
        }
        
        attributes.avaterFrame = avatarFrame(with: message)
        
        setupUsernameFrame(with: attributes, message: message)
        setupContainerFrame(with: attributes, message: message)
        setupStateFrame(with: attributes, message: message)
    }
    
    // 头像
    func avatarFrame(with message: MessageModel) -> CGRect {
        let size: CGSize = setting.kAvaterSize
        let origin: CGPoint
        if message.isSend {
            origin = CGPoint(x: itemWidth - setting.kMessageToLeftPadding - size.width,
                             y: setting.kMessageToTopPadding)
        } else {
            origin = CGPoint(x: setting.kMessageToLeftPadding, y: setting.kMessageToTopPadding)
        }
        return CGRect(origin: origin, size: size)
    }
    
    // 昵称(如果有昵称，则昵称和头像y一样)
    func setupUsernameFrame(with attributes: MessageLayoutAttributes, message: MessageModel) {
        
        var size: CGSize = setting.kUsernameSize
        let origin: CGPoint
        if message.showUsername == false {
            size = CGSize.zero
        }
        
        if message.isSend {
            origin = CGPoint(x: attributes.avaterFrame.minX - setting.kUsernameLeftPadding - size.width,
                             y: attributes.avaterFrame.minY)
        } else {
            origin = CGPoint(x: attributes.avaterFrame.maxX + setting.kUsernameLeftPadding,
                             y: attributes.avaterFrame.minY)
        }
        attributes.usernameFrame = CGRect(origin: origin, size: size)
    }
    
    func setupContainerFrame(with attributes: MessageLayoutAttributes, message: MessageModel) {
        
        // 如果是文字
        var contentSize: CGSize = CGSize.zero
        
        switch message.messageType {
        case .text:
            break
//            let content = (message.messageBody as! TextMessageBody).text
//            let size = CGSize(width: kChatTextMaxWidth, height: CGFloat.greatestFiniteMagnitude)
//            var edge: UIEdgeInsets
//            if message.isSend {
//                edge = ChatCellUI.right_edge_insets
//            } else {
//                edge = ChatCellUI.left_edge_insets
//            }
//            
//            let modifier = CWTextLinePositionModifier(font: setting.contentTextFont)
//            // YYTextContainer
//            let textContainer = YYTextContainer(size: size)
//            textContainer.linePositionModifier = modifier
//            textContainer.maximumNumberOfRows = 0
//            
//            let textFont = setting.contentTextFont
//            let textAttributes = [NSAttributedStringKey.font: textFont,
//                                  NSAttributedStringKey.foregroundColor: UIColor.black]
//            
//            let textAttri = CWChatTextParser.parseText(content, attributes: textAttributes)!
//            let textLayout = YYTextLayout(container: textContainer, text: textAttri)!
//            
//            contentSize = CGSize(width: textLayout.textBoundingSize.width+edge.left+edge.right,
//                                 height: textLayout.textBoundingSize.height+edge.top+edge.bottom)
//            message.textLayout = textLayout
            
        case .image:
            let imageSize = (message.messageBody as! ImageMessageBody).size
            //根据图片的比例大小计算图片的frame
            if imageSize.width > imageSize.height {
                var height = kChatImageMaxWidth * imageSize.height / imageSize.width
                height = max(kChatImageMinWidth, height)
                contentSize = CGSize(width: ceil(kChatImageMaxWidth), height: ceil(height))
            } else {
                var width = kChatImageMaxWidth * imageSize.width / imageSize.height
                width = max(kChatImageMinWidth, width)
                contentSize = CGSize(width: ceil(width), height: ceil(kChatImageMaxWidth))
            }
            
            let edge = UIEdgeInsets.zero
            contentSize = CGSize(width: contentSize.width+edge.left+edge.right,
                                 height: contentSize.height+edge.top+edge.bottom)
            
        case .voice:
            
            let voiceMessage = message.messageBody as! VoiceMessageBody
            var scale: CGFloat = CGFloat(voiceMessage.voiceLength)/60.0
            if scale > 1 {
                scale = 1
            }
            contentSize = CGSize(width: ceil(scale*kChatVoiceMaxWidth)+70,
                                 height: setting.kAvaterSize.height+13)
            
        case .emoticon:
            contentSize = CGSize(width: 120, height: 120)
            
        case .location:
            contentSize = CGSize(width: 250, height: 150)
            
        default:
            break
        }
        
        
        
        let origin: CGPoint
        if message.isSend {
            origin = CGPoint(x: attributes.avaterFrame.minX - setting.kUsernameLeftPadding - contentSize.width,
                             y: attributes.usernameFrame.minY)
        } else {
            origin = CGPoint(x: attributes.avaterFrame.maxX + setting.kUsernameLeftPadding,
                             y: attributes.usernameFrame.minY)
        }
        attributes.messageContainerFrame = CGRect(origin: origin, size: contentSize)
    }
    
    func setupStateFrame(with attributes: MessageLayoutAttributes, message: MessageModel) {
        let containerFrame = attributes.messageContainerFrame
        let origin: CGPoint
        if message.isSend {
            origin = CGPoint(x: containerFrame.minX - 2 - setting.errorSize.width,
                             y: containerFrame.midY - 10)
        } else {
            origin = CGPoint(x: containerFrame.minX + 2 + setting.errorSize.width,
                             y: containerFrame.midY - 10)
        }
        attributes.errorFrame = CGRect(origin: origin, size: setting.errorSize)
        attributes.activityFrame = CGRect(origin: origin, size: setting.errorSize)
    }
    
}
