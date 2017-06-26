//
//  ActionSheetExtension.swift
//  CustomSheet
//
//  Created by wuguanyu on 16/9/26.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import UIKit

extension ActionSheetController {
    class var customSheet: ActionSheetController {
        let actionSheet = ActionSheetController()
        actionSheet.preferredCommonStyle = [
            .blurBackground(true),
            .bounceShow(true)
        ]
        return actionSheet
    }

    class var logoutStyle: [ActionSheetOption] {
        return [
            .sepLineHeight(1),
            .sepLineColor(.lightGray),
            .sepLineLeftMargin(20)
        ]
    }

    class var cleanStyle: [ActionSheetOption] {
        return [
            .sepLineHeight(1),
            .sepLineColor(.blue)
        ]
    }

}
