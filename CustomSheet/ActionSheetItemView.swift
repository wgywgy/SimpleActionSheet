//
//  ActionSheetItemView.swift
//  CustomSheet
//
//  Created by wuguanyu on 16/9/23.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import UIKit

class ActionSheetItemView: UIView {

    lazy var titleLabel: UILabel = {
        let aLabel = UILabel()
        aLabel.textAlignment = .center
        aLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.addSubview(aLabel)

        return aLabel
    }()

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setting()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setting()
    }

    init() {
        super.init(frame: CGRect.zero)
        self.setting()
    }

    func setting() {
        self.clipsToBounds = true
    }
    
    func setStyle(_ item: ActionSheetItemModel) {
        backgroundColor = item.backGroundColor
        titleLabel.text = item.title
        titleLabel.textColor = item.fontColor
        titleLabel.font = item.font
    }

}
