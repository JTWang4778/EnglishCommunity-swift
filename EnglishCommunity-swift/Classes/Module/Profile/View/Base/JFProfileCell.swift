//
//  JFProfileCell.swift
//  BaoKanIOS
//
//  Created by zhoujianfeng on 16/5/5.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

class JFProfileCell: UITableViewCell {

    /// 是否显示分割线
    var showLineView: Bool = false {
        didSet {
            settingLineView.hidden = !showLineView
        }
    }
    
    /// cell模型
    var cellModel: JFProfileCellModel? {
        didSet {
            
            // 左边数据
            textLabel?.text = cellModel!.title
            detailTextLabel?.text = cellModel!.subTitle
            
            if cellModel?.icon != nil {
                imageView?.image = UIImage(named: cellModel!.icon!)
            } else {
                imageView?.image = nil
            }
            
            // 右边数据
            selectionStyle = cellModel!.isKindOfClass(JFProfileCellArrowModel.self) ? .Default : .None
            if cellModel!.isKindOfClass(JFProfileCellArrowModel.self) {
                let settingCellArrow = cellModel as! JFProfileCellArrowModel
                settingRightLabel.text = settingCellArrow.text
                accessoryView = rightView
            } else if cellModel!.isKindOfClass(JFProfileCellSwitchModel.self) {
                let settingCellSwitch = cellModel as! JFProfileCellSwitchModel
                settingSwitchView.on = settingCellSwitch.on
                accessoryView = settingSwitchView
            } else if cellModel!.isKindOfClass(JFProfileCellLabelModel.self) {
                let settingCellLabel = cellModel as! JFProfileCellLabelModel
                settingRightLabel.text = settingCellLabel.text
                accessoryView = settingRightLabel
            }
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 准备视图
        prepareUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let lineX = textLabel!.frame.origin.x
        let lineH: CGFloat = 0.5
        let lineY = frame.size.height - lineH
        let lineW = frame.size.width - lineX
        settingLineView.frame = CGRect(x: lineX, y: lineY, width: lineW, height: lineH)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareUI() {
        
        selectionStyle = .None
        textLabel?.font = UIFont.systemFontOfSize(14)
        textLabel?.textColor = UIColor.colorWithHexString("444444")
        textLabel?.backgroundColor = UIColor.clearColor()
        
        detailTextLabel?.font = UIFont.systemFontOfSize(11)
        detailTextLabel?.textColor = UIColor.blackColor()
        
        contentView.addSubview(settingLineView)
    }
    
    @objc private func didChangedSwitch(settingSwitch: UISwitch) {
        // 修改本地存储的状态
//        NSUserDefaults.standardUserDefaults().setBool(settingSwitch.on, forKey: NIGHT_KEY)
    }
    
    // MARK: - 懒加载
    lazy var settingRightLabel: UILabel = {
        let settingRightLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 20))
        settingRightLabel.textColor = UIColor.grayColor()
        settingRightLabel.textAlignment = .Right
        settingRightLabel.font = UIFont.systemFontOfSize(12)
        return settingRightLabel
    }()
    
    lazy var settingArrowView: UIImageView = {
        let settingArrowView = UIImageView(image: UIImage(named: "setting_arrow_icon"))
        return settingArrowView
    }()
    
    lazy var settingSwitchView: UISwitch = {
        let settingSwitchView = UISwitch()
        settingSwitchView.addTarget(self, action: #selector(didChangedSwitch(_:)), forControlEvents: .ValueChanged)
        return settingSwitchView
    }()
    
    lazy var settingLineView: UIView = {
        let settingLineView = UIView()
        settingLineView.backgroundColor = UIColor.blackColor()
        settingLineView.alpha = 0.1
        return settingLineView
    }()
    
    lazy var rightView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 180, height: 20))
        view.backgroundColor = UIColor.clearColor()
        view.addSubview(self.settingArrowView)
        view.addSubview(self.settingRightLabel)
        self.settingArrowView.frame = CGRect(x: 170, y: 2.5, width: 15, height: 15)
        self.settingRightLabel.frame = CGRect(x: 0, y: 0, width: 165, height: 20)
        return view
    }()

}