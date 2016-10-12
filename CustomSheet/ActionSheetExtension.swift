//
//  ActionSheetExtension.swift
//  CustomSheet
//
//  Created by wuguanyu on 16/9/26.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import UIKit

extension ActionSheetController {
    class func custom() -> ActionSheetController {
        let actionSheet = ActionSheetController()
        actionSheet.preferredCommonStyle = [
            .blurBackground(true),
            .bounceShow(true)
        ]
        return actionSheet
    }

    class func logoutStyle() -> [ActionSheetOption] {
        return [
            .sepLineHeight(1),
            .sepLineColor(.lightGray),
            .sepLineLeftMargin(20),
            ]
    }

    class func cleanStyle() -> [ActionSheetOption] {
        return [
            .sepLineHeight(1),
            .sepLineColor(.blue),
            ]
    }

}
