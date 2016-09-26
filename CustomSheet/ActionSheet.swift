//
//  ActionSheet.swift
//  CustomSheet
//
//  Created by wuguanyu on 16/9/23.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import UIKit

public enum ActionSheetOption {
    case SepLineHeight(CGFloat)
    case SepLineColor(UIColor)
    case SepLineWidth(CGFloat)
    case SepLineLeftMargin(CGFloat)
}

public class ActionSheet: NSObject {

    public var items = [ActionSheetItem]()

    var closeAction: (() -> Void)?

    // View
    var sepLineHeight: CGFloat = 1
    var sepLineColor: UIColor = UIColor.lightGrayColor()
    var sepLineWidth: CGFloat = UIScreen.mainScreen().bounds.width
    var sepLineLeftMargin: CGFloat = 0

    private lazy var maskView: UIView = {
        let aView = UIView()
        aView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        aView.frame = self.screenBounds
        aView.alpha = 0
        let maskViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(maskViewWasTapped))
        aView.addGestureRecognizer(maskViewTapGesture)

        return aView
    }()

    private lazy var itemContainerView: UIView = {
        let aItemContainerView = UIView()
        return aItemContainerView
    }()

    func createSepLineView() -> UIView {
        let aSepLineView = UIView()
        aSepLineView.backgroundColor = sepLineColor
        return aSepLineView
    }

    let screenBounds = UIScreen.mainScreen().bounds

    public var options = [ActionSheetOption]() {
        didSet {
            processOptions()
        }
    }

    func processOptions() {
        for option in options {
            switch option {
            case let .SepLineHeight(value):
                sepLineHeight = value
            case let .SepLineColor(value):
                sepLineColor = value
            case let .SepLineWidth(value):
                sepLineWidth = value
            case let .SepLineLeftMargin(value):
                sepLineLeftMargin = value
            }
        }
    }

    public init(options: [ActionSheetOption]) {
        super.init()

        self.options = options
        processOptions()
    }

    public func showInWindow(items: [ActionSheetItem]? = nil, closeBlock: (() -> Void)? = nil) {
        let window = UIApplication.sharedApplication().delegate?.window
        showInView(window!!, items: items, closeBlock: closeBlock)
    }

    public func showInView(targetView: UIView, items: [ActionSheetItem]? = nil, closeBlock: (() -> Void)? = nil) {
        if let items = items {
            self.items = items
        }
        self.closeAction = closeBlock

        targetView.addSubview(maskView)

        var currentPosition: CGFloat = 0
        var totalItemsHeight: CGFloat = 0

        for i in (0 ..< self.items.count) {
            let aItem = self.items[i]
            let itemOriginPoint = CGPoint(x: 0, y: currentPosition)
            let itemSize = CGSize(width: screenBounds.width, height: aItem.height)
            let aItemView = ActionSheetItemView(frame: CGRect(origin: itemOriginPoint, size: itemSize))
            aItemView.backgroundColor = aItem.backGroundColor
            aItemView.titleLabel.text = aItem.title
            aItemView.titleLabel.textColor = aItem.fontColor
            aItemView.titleLabel.font = aItem.font

            aItemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionSheet.buttonWasTapped(_:))))

            itemContainerView.addSubview(aItemView)
            currentPosition += aItem.height

            if i == self.items.count - 1 {
                continue
            }
            let aSep = createSepLineView()
            aSep.frame = CGRect(x: sepLineLeftMargin, y: currentPosition, width: sepLineWidth, height: sepLineHeight)
            itemContainerView.addSubview(aSep)

            currentPosition += sepLineHeight
        }

        totalItemsHeight = currentPosition

        targetView.addSubview(itemContainerView)
        itemContainerView.frame = CGRect(x: 0, y: screenBounds.height, width: screenBounds.width, height: totalItemsHeight)

        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
            self.maskView.alpha = 1
            self.itemContainerView.frame = CGRect(x: 0, y: self.screenBounds.height - totalItemsHeight, width: self.screenBounds.width, height: totalItemsHeight)
            }) { (finish) in
        }
    }

    public func dismiss() {
        UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
            self.itemContainerView.frame = CGRect(x: 0, y: self.screenBounds.height, width: self.screenBounds.width, height: self.itemContainerView.frame.height)
            self.maskView.alpha = 0
            }) { (finish) in
                self.itemContainerView.removeFromSuperview()
                self.maskView.removeFromSuperview()

                self.closeAction?()
        }
    }
}

extension ActionSheet {
    func maskViewWasTapped() {
        dismiss()
    }

    func buttonWasTapped(sender: UITapGestureRecognizer) {
        guard let aItemView = sender.view as? ActionSheetItemView else {
            return
        }

        for item in items {
            if aItemView.titleLabel.text == item.title {
                item.selectAction?(actionSheet: self)
            }
        }
    }
}