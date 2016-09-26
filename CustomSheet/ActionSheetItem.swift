//
//  ActionSheetItem.swift
//  CustomSheet
//
//  Created by wuguanyu on 16/9/23.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import UIKit

public protocol ActionSheetItemModel {
    var title: String { get set }
    var font: UIFont { get set }
    var fontColor: UIColor { get set }
    var height: CGFloat { get set }
    var selectAction: ((actionSheet: ActionSheet) -> Void)? { get set }
    var backGroundColor: UIColor { get set }

    init(title: String, font: UIFont, fontColor: UIColor, backGroundColor: UIColor, height: CGFloat, selectAction: ((actionSheet: ActionSheet) -> Void)?)
}

public struct ActionSheetItem: ActionSheetItemModel {
    public var title = ""
    public var font: UIFont
    public var fontColor: UIColor
    public var height: CGFloat
    public var selectAction: ((actionSheet: ActionSheet) -> Void)?
    public var backGroundColor: UIColor
}

extension ActionSheetItem {
    public init(title: String, font: UIFont = UIFont.systemFontOfSize(14), fontColor: UIColor = UIColor.blackColor(), backGroundColor: UIColor = UIColor.whiteColor(), height: CGFloat = 44, selectAction: ((actionSheet: ActionSheet) -> Void)?) {
        self.title = title
        self.fontColor = fontColor
        self.height = height
        self.selectAction = selectAction
        self.backGroundColor = backGroundColor
        self.font = font
    }
}

public struct CancelActionSheetItem: ActionSheetItemModel {
    public var title = ""
    public var font: UIFont
    public var fontColor: UIColor
    public var height: CGFloat
    public var selectAction: ((actionSheet: ActionSheet) -> Void)?
    public var backGroundColor: UIColor

    public init(title: String = "取消", font: UIFont = UIFont.boldSystemFontOfSize(14), fontColor: UIColor = UIColor.blackColor(), backGroundColor: UIColor = UIColor.whiteColor(), height: CGFloat = 44, selectAction:
        ((actionSheet: ActionSheet) -> Void)?) {
        self.title = title
        self.fontColor = fontColor
        self.height = height
        self.selectAction = selectAction
        self.backGroundColor = backGroundColor
        self.font = font
    }
}
