//
//  ViewController.swift
//  CustomSheet
//
//  Created by wuguanyu on 16/9/23.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var actionSheet: ActionSheetController = {
        return ActionSheetController.customSheet
    }()

    lazy var actionSheetItem: [ActionSheetItemModel] = {
        let logoutActionItem = ActionSheetItem(title: "退出登录") { [unowned self] (actionSheet) in
            self.logout()
            actionSheet.dismiss()
        }

        let cancelActionItem = CancelActionSheetItem { (actionSheet) in
            print("cancel")
            actionSheet.dismiss()
        }

        return [logoutActionItem, cancelActionItem]
    }()

    lazy var actionSheetItem2: [ActionSheetItemModel] = {
        let cleanActionItem = ActionSheetItem(title: "Action 1") { [unowned self] (actionSheet) in
            self.clean()
        }

        let cleanActionItem2 = ActionSheetItem(title: "Action 2") { [unowned self] (actionSheet) in
            self.clean()
        }

        let cancelActionItem = CancelActionSheetItem { (actionSheet) in
            print("cancel")
            actionSheet.dismiss()
        }

        return [cleanActionItem, cleanActionItem2, cancelActionItem]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    deinit {
        print("over")
    }

    @IBAction func showSheet(_ sender: AnyObject) {
        actionSheet.items = actionSheetItem
        actionSheet.showInWindow(preferredStyle: ActionSheetController.logoutStyle)
    }

    @IBAction func showSheet2(_ sender: AnyObject) {
        actionSheet.items = actionSheetItem2
        actionSheet.preferredStyle = ActionSheetController.cleanStyle
        actionSheet.showInWindow()
    }

}

// MARK: ActionSheet action
extension ViewController {
    func logout() {
        print("logout")
    }
    
    func clean() {
        print("clean")
    }
}
