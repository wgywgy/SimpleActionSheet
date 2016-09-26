//
//  ActionSheetExtension.swift
//  CustomSheet
//
//  Created by wuguanyu on 16/9/26.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import UIKit

extension ActionSheet {
    class func customSheet() -> ActionSheet {
        let actionSheet = ActionSheet()
//        actionSheet.options =
        return actionSheet
    }

    class func logoutStyle() -> [ActionSheetOption] {
        let options: [ActionSheetOption] = [
            ActionSheetOption.SepLineHeight(1),
            ActionSheetOption.SepLineColor(UIColor.lightGrayColor()),
            ActionSheetOption.SepLineLeftMargin(20),
            ]
        return options
    }

    class func cleanStyle() -> [ActionSheetOption] {
        let options: [ActionSheetOption] = [
            ActionSheetOption.SepLineHeight(1),
            ActionSheetOption.SepLineColor(UIColor.blueColor()),
            ]
        return options
    }

}
