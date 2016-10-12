//
//  ActionSheet.swift
//  CustomSheet
//
//  Created by wuguanyu on 16/9/23.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import UIKit

public enum ActionSheetCommonOption {
    case blurBackground(Bool)
    case darkBackgroundColor(Bool)
    case bounceShow(Bool)
}

public enum ActionSheetOption {
    case sepLineHeight(CGFloat)
    case sepLineColor(UIColor)
    case sepLineWidth(CGFloat)
    case sepLineLeftMargin(CGFloat)
}

struct ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = min(ScreenSize.width, ScreenSize.height)
}

open class ActionSheetController: UIViewController {

    open var items = [ActionSheetItemModel]()

    var closeAction: (() -> Void)?

    var totalItemsHeight: CGFloat = 0
    
    var actionSheetItemViews = [ActionSheetItemView]()
    var sepLineViews = [UIView]()

    // ActionSheetCommonOption var
    var blurBackground = false
    var darkBackgroundColor = true
    var bounceShow = false
    
    // ActionSheetOption var
    var sepLineHeight: CGFloat = 1
    var sepLineColor: UIColor = .lightGray
    var sepLineWidth: CGFloat = ScreenSize.width
    var sepLineLeftMargin: CGFloat = 0
    
    @IBOutlet weak var maskBgView: UIView!
    var containerWindow: UIWindow = {
        let originFrame = CGRect(x: 0, y: -20, width: ScreenSize.width, height: 20)
        let aWindow = UIWindow(frame: originFrame)
//        aWindow.isHidden = false
        aWindow.windowLevel = UIWindowLevelAlert
        
        return aWindow

    }()
    
    fileprivate lazy var maskView: UIView = {
        let aView: UIView
        if self.blurBackground {
            aView = self.createBlurView(frame: self.screenBounds)
        } else {
            aView = UIView(frame: self.screenBounds)
            aView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
        
        aView.alpha = 0
        let maskViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(maskViewWasTapped))
        aView.addGestureRecognizer(maskViewTapGesture)
        return aView
    }()

    fileprivate lazy var itemContainerView: UIView = {
        let aItemContainerView = UIView()
        aItemContainerView.backgroundColor = .white
        return aItemContainerView
    }()

    func createSepLineView() -> UIView {
        let aSepLineView = UIView()
        aSepLineView.backgroundColor = sepLineColor
        return aSepLineView
    }

    var screenBounds: CGRect {
        get {
            return UIScreen.main.bounds
        }
    }

    open var commonOptions = [ActionSheetCommonOption]() {
        didSet {
            for option in commonOptions {
                switch option {
                case let .blurBackground(value):
                    blurBackground = value
                case let .bounceShow(value):
                    bounceShow = value
                case let .darkBackgroundColor(value):
                    darkBackgroundColor = value
                }
            }
        }
    }
    
    open var options = [ActionSheetOption]() {
        didSet {
            restoreProperty()
            for option in options {
                switch option {
                case let .sepLineHeight(value):
                    sepLineHeight = value
                case let .sepLineColor(value):
                    sepLineColor = value
                case let .sepLineWidth(value):
                    sepLineWidth = value
                case let .sepLineLeftMargin(value):
                    sepLineLeftMargin = value
                }
            }
        }
    }

    func restoreProperty() {
        sepLineHeight = 1
        sepLineColor = .lightGray
        sepLineWidth = UIScreen.main.bounds.width
        sepLineLeftMargin = 0
    }
    
    // Mark Action:
    open func showInWindow(_ items: [ActionSheetItemModel]? = nil, options: [ActionSheetOption]? = nil, closeBlock: (() -> Void)? = nil) {
        let window = UIApplication.shared.delegate?.window
        showInView(window!!, items: items, options: options, closeBlock: closeBlock)
    }

    open func showInView(_ targetView: UIView, items: [ActionSheetItemModel]? = nil, options: [ActionSheetOption]? = nil, closeBlock: (() -> Void)? = nil) {
        if let items = items {
            self.items = items
        }
        self.closeAction = closeBlock

        if let options = options {
            self.options = options
        }

        maskView.frame = screenBounds
        targetView.addSubview(maskView)

        setupContainerView()
        targetView.addSubview(itemContainerView)

        itemContainerView.frame = CGRect(x: 0, y: screenBounds.height, width: screenBounds.width, height: totalItemsHeight)
        
        if bounceShow {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.68, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                self.maskView.alpha = 1.0
                self.itemContainerView.frame = CGRect(x: 0, y: self.screenBounds.height - self.totalItemsHeight, width: self.screenBounds.width, height: self.totalItemsHeight)
            })
        } else {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.maskView.alpha = 1.0
                self.itemContainerView.frame = CGRect(x: 0, y: self.screenBounds.height - self.totalItemsHeight, width: self.screenBounds.width, height: self.totalItemsHeight)
            })
        }
    }

    func setupContainerView() {
        var currentPosition: CGFloat = 0

        for i in (0 ..< items.count) {
            let aItem = items[i]
            let itemOriginPoint = CGPoint(x: 0, y: currentPosition)
            let itemSize = CGSize(width: screenBounds.width, height: aItem.height)
            let aItemView = ActionSheetItemView(frame: CGRect(origin: itemOriginPoint, size: itemSize))
            aItemView.setStyle(aItem)
            actionSheetItemViews.append(aItemView)

            aItemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionSheetController.buttonWasTapped(_:))))

            itemContainerView.addSubview(aItemView)
            currentPosition += aItem.height

            if i < items.count - 1 {
                let aSep = createSepLineView()
                aSep.frame = CGRect(x: sepLineLeftMargin, y: currentPosition, width: sepLineWidth, height: sepLineHeight)
                sepLineViews.append(aSep)
                itemContainerView.addSubview(aSep)

                currentPosition += sepLineHeight
            }
        }

        totalItemsHeight = currentPosition
    }

    open func dismiss() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.itemContainerView.frame = CGRect(x: 0, y: self.screenBounds.height, width: self.screenBounds.width, height: self.itemContainerView.frame.height)
            self.maskView.alpha = 0
            }) { (finish) in
                self.itemContainerView.removeFromSuperview()
                self.maskView.removeFromSuperview()
                for actionSheetItemView in self.actionSheetItemViews {
                    actionSheetItemView.removeFromSuperview()
                }
                self.actionSheetItemViews.removeAll()
                
                for sepLineView in self.sepLineViews {
                    sepLineView.removeFromSuperview()
                }
                self.sepLineViews.removeAll()

                self.closeAction?()
        }
    }
}

extension ActionSheetController {
    func createBlurView(frame: CGRect) -> UIView {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }
}

extension ActionSheetController {
    func maskViewWasTapped() {
        dismiss()
    }

    func buttonWasTapped(_ sender: UITapGestureRecognizer) {
        guard let aItemView = sender.view as? ActionSheetItemView else {
            return
        }

        for item in items {
            if aItemView.titleLabel.text == item.title {
                item.selectAction?(self)
            }
        }
    }
}
