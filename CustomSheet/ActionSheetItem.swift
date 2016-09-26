//
//  ActionSheetItem.swift
//  CustomSheet
//
//  Created by wuguanyu on 16/9/23.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import UIKit

public class ActionSheetItem {
    var title = ""
    var fontColor: UIColor
    var height: CGFloat
    var selectAction: ((actionSheet: ActionSheet) -> Void)?
    var backGroundColor: UIColor
    var font: UIFont

    public init(title: String, font: UIFont = UIFont.systemFontOfSize(14), fontColor: UIColor = UIColor.blackColor(), backGroundColor: UIColor = UIColor.whiteColor(), height: CGFloat = 44, selectAction: ((actionSheet: ActionSheet) -> Void)?) {
        self.title = title
        self.fontColor = fontColor
        self.height = height
        self.selectAction = selectAction
        self.backGroundColor = backGroundColor
        self.font = font
    }
}

public class CancelActionSheetItem: ActionSheetItem {
    public override init(title: String = "取消", font: UIFont = UIFont.boldSystemFontOfSize(14), fontColor: UIColor = UIColor.blackColor(), backGroundColor: UIColor = UIColor.whiteColor(), height: CGFloat = 44, selectAction:
        ((actionSheet: ActionSheet) -> Void)?) {
        super.init(title: title, font: font, fontColor: fontColor, backGroundColor: backGroundColor, height: height, selectAction: selectAction)
    }
}
