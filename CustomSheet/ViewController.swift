//
//  ViewController.swift
//  CustomSheet
//
//  Created by wuguanyu on 16/9/23.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var actionSheet: ActionSheet = {
        let actSheet = ActionSheet.makeCustomActionSheet()
        return actSheet
    }()

    lazy var actionSheetItem: [ActionSheetItem] = {
        let aActionItem = ActionSheetItem(title: "退出登录") { [weak self] (actionSheet) in
            guard let `self` = self else { return }
            self.logout()
        }

        let cancelActionItem = CancelActionSheetItem { (actionSheet) in
            print("cancel")
            actionSheet.dismiss()
        }

        return [aActionItem, cancelActionItem]
    }()

    lazy var actionSheetItem2: [ActionSheetItem] = {
        let aActionItem = ActionSheetItem(title: "清除系统缓存(不删除已缓存影片)") { [weak self] (actionSheet) in
            guard let `self` = self else { return }
            self.clean()
        }

        let cancelActionItem = CancelActionSheetItem { (actionSheet) in
            print("cancel")
            actionSheet.dismiss()
        }

        return [aActionItem, cancelActionItem]
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    deinit {
        print("over")
    }

    @IBAction func showSheet(sender: AnyObject) {
        actionSheet.items = actionSheetItem
        actionSheet.options = ActionSheet.logoutStyle()
        actionSheet.showInWindow()
    }

    @IBAction func showSheet2(sender: AnyObject) {
        actionSheet.items = actionSheetItem2
        actionSheet.options = ActionSheet.cleanStyle()
        actionSheet.showInWindow()
    }

    func logout() {
        print("logout")
    }

    func clean() {
        print("clean")
    }
}
