//
//  CWEmoticonScrollView.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/20.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

protocol CWEmoticonScrollViewDelegate: NSObjectProtocol {
    func emoticonScrollViewDidTapCell(_ cell: CWEmoticonCell)
}

class CWEmoticonScrollView: UICollectionView {

    // magnifier是长按 之后展示表情的部分
    var magnifier: UIImageView = {
        let magnifier = UIImageView(image: UIImage(named: "EmoticonTips"))
        magnifier.size = CGSize(width: 50, height: 80)
        magnifier.isHidden = true
        return magnifier
    }()
    
    var touchMoved = false
    weak var currentMagnifierCell: CWEmoticonCell?
    var backspaceTimer: Timer?
    
    var magnifierLabel: UILabel = {
        let magnifierLabel = UILabel()
        magnifierLabel.textAlignment = .center
        magnifierLabel.font = UIFont.systemFont(ofSize: 12)
        magnifierLabel.textColor = UIColor.gray
        magnifierLabel.size = CGSize(width: 40, height: 15)
        return magnifierLabel
    }()
    
    var magnifierContent: UIImageView = {
        let magnifierContent = UIImageView()
        magnifierContent.size = CGSize(width: 35, height: 35)
        return magnifierContent
    }()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        magnifier.addSubview(magnifierLabel)
        magnifier.addSubview(magnifierContent)
        magnifierContent.centerX = magnifier.width/2
        magnifierLabel.top = 49
        magnifierLabel.centerX = magnifier.width/2

        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = true
        self.canCancelContentTouches = false
        self.isMultipleTouchEnabled = false
        self.clipsToBounds = false
        self.addSubview(magnifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchMoved = false
        guard let cell = cellForTouches(touches) else {
            return
        }
        currentMagnifierCell = cell
        showMagnifierForCell(cell)
        endBackspaceTimer()
        self.perform(#selector(startBackspaceTimer), with: nil, afterDelay: 0.5)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchMoved = true
        if let cell = currentMagnifierCell, cell.isDelete == true {
            return
        }
        
        guard let cell = cellForTouches(touches),
            cell != currentMagnifierCell else {
            return
        }
        
        if (currentMagnifierCell?.isDelete == false && !cell.isDelete) {
            currentMagnifierCell = cell;
        }
        showMagnifierForCell(cell)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let cell = cellForTouches(touches),
        let preCell = currentMagnifierCell else {
            return
        }
        
        let isEmoticon = preCell.isDelete == false && preCell.emoticon != nil
        let isTouch = touchMoved == false && cell.isDelete == false
        if isEmoticon || isTouch {
            if let _delegate = self.delegate as? CWEmoticonScrollViewDelegate {
                _delegate.emoticonScrollViewDidTapCell(cell)
            }
        }
        
        hideMagnifier()
        endBackspaceTimer()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideMagnifier()
        endBackspaceTimer()
    }

    func cellForTouches(_ touches: Set<UITouch>) -> CWEmoticonCell? {
        let touch = touches.first
        
        guard let point = touch?.location(in: self),
            let indexPath = self.indexPathForItem(at: point),
        let cell = self.cellForItem(at: indexPath) as? CWEmoticonCell else {
            return nil
        }
        return cell
    }
    
    func startBackspaceTimer() {
        endBackspaceTimer()
        
        if #available(iOS 10.0, *) {
            backspaceTimer = Timer(timeInterval: 0.1, repeats: true, block: { [weak self] (timer) in
                guard let strongSelf = self,
                 let cell = strongSelf.currentMagnifierCell,
                    cell.isDelete == true else {
                    return
                }
                
                if let _delegate = self?.delegate as? CWEmoticonScrollViewDelegate {
                    _delegate.emoticonScrollViewDidTapCell(cell)
                }
            })
        } else {
            // Fallback on earlier versions
        }
        
        if let backspaceTimer = self.backspaceTimer  {
            RunLoop.main.add(backspaceTimer, forMode: .commonModes)
        }
    }
    
    func endBackspaceTimer() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(startBackspaceTimer), object: nil)
        backspaceTimer?.invalidate()
        backspaceTimer = nil
    }
    
    func showMagnifierForCell(_ cell: CWEmoticonCell) {
        
        if cell.isDelete || cell.imageView.image == nil {
            hideMagnifier()
            return
        }
        
        let rect = cell.convert(cell.bounds, to: self)
        magnifier.centerX = rect.midX
        magnifier.bottom = rect.maxY - 9;
        magnifier.isHidden = false;
        
        magnifierLabel.text = cell.emoticon?.chs
        
        magnifierContent.image = cell.imageView.image
        magnifierContent.top = 20;

        magnifierContent.layer.removeAllAnimations()
        
        let duration = 0.1
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            self.magnifierContent.top = 3
        }) { (finished) in
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
                self.magnifierContent.top = 6
            }) { (finished) in
                UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
                    self.magnifierContent.top = 5
                }) { (finished) in
                }
            }
        }
    }
    
    func hideMagnifier() {
        magnifier.isHidden = true
    }
    
}
