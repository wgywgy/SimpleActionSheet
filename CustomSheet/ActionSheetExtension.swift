//
//  ActionSheetExtension.swift
//  CustomSheet
//
//  Created by wuguanyu on 16/9/26.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import UIKit

extension ActionSheet {
    class func makeCustomActionSheet() -> ActionSheet {
        let actionSheet = ActionSheet(options: logoutStyle())
        return actionSheet
    }

    class func logoutStyle() -> [ActionSheetOption] {
        let options: [ActionSheetOption] = [
            ActionSheetOption.SepLineHeight(2),
            ActionSheetOption.SepLineColor(UIColor.greenColor()),
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
