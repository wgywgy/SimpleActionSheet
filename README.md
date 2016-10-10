# SimpleActionSheet
Warn: Still edit.

A Simple ActionSheet writen in Swift

![](https://img.shields.io/badge/Swift-3.0-blue.svg?style=flat)
[![Build Status][image-1]][1]
[![codebeat badge][image-2]][2]
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Screenshots
<p align="center">
<img src="https://github.com/wgywgy/SimpleActionSheet/blob/master/DemoPic/Demo1.png" alt="Screenshots1" title="Screenshots1" width="320"/>
</p>

## Install
**CocoaPods**

```
pod install 'SimpleActionSheet'
```

**Carthage**

SimpleActionSheet is also available through [Carthage][4].  Append this line to Cartfile and follow [this instruction][5].

```
github "wgywgy/SimpleActionSheet"
```

## Requirements

- iOS 8.0+

## Use

STEP1: Init a ActionSheet and ActionSheetItem.

```swift
lazy var actionSheet: ActionSheet = {
    let actionSheet = ActionSheet()
    return actionSheet
}()

lazy var actionSheetItem: [ActionSheetItemModel] = {
    let logoutActionItem = ActionSheetItem(title: "退出登录") { [weak self] (actionSheet) in
        guard let `self` = self else { return }
        self.logout()
    }

    let cancelActionItem = CancelActionSheetItem { (actionSheet) in
        print("cancel")
        actionSheet.dismiss()
    }

    return [logoutActionItem, cancelActionItem]
}()
```

STEP 2: Define ActionSheet in extension.

```swift
extension ActionSheet {
    class func logoutStyle() -> [ActionSheetOption] {
        let options: [ActionSheetOption] = [
            ActionSheetOption.sepLineHeight(1),
            ActionSheetOption.sepLineColor(UIColor.lightGray),
            ActionSheetOption.sepLineLeftMargin(20),
            ]
        return options
    }
}
```

STEP 3: Show Action as below.

```swift
actionSheet.items = actionSheetItem
actionSheet.showInWindow(options: ActionSheet.logoutStyle())
```

More method can look at ActionSheet.swift.

License
=======
SimpleActionSheet is released under the MIT license. See LICENSE for details.

[1]:	https://travis-ci.org/wgywgy/SimpleActionSheet
[2]:	https://codebeat.co/projects/github-com-wgywgy-simpleactionsheet
[4]:	https://github.com/carthage/carthage
[5]:	https://github.com/carthage/carthage#adding-frameworks-to-an-application

[image-1]:	https://travis-ci.org/wgywgy/SimpleActionSheet.svg?branch=master
[image-2]:	https://codebeat.co/badges/1cc92497-a605-4d6e-b87c-d67973057454
