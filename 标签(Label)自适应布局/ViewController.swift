//
//  ViewController.swift
//  标签(Label)自适应布局
//
//  Created by haspay on 16/4/6.
//  Copyright © 2016年 DZM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化 字符串数组
        let labels = ["爱好","1","标签", "222","ASDC","asd","a","&^^%","测试","asdkjhaskdjlkas","卡视角的"]
        
        // 获取自适应对象
        let adaptive = setupAdaptive(labels)
        
        // 假如创建的别 view 放label 使用高度可直接获取
        print(" 需要显示view高: \(adaptive.maxH)")
        
        for i in 0 ..< labels.count {
            
            let label = UILabel()
            
            // 字体注意跟计算的时候使用一样
            label.font = UIFont.systemFontOfSize(20)
            
            label.textAlignment = NSTextAlignment.Center
            
            // 两种赋值都行
            label.text = adaptive.adaptiveArray[i]
//            label.text = labels[i]
            
            label.textColor = UIColor.redColor()
            
            label.layer.borderColor = UIColor.redColor().CGColor
            
            label.layer.borderWidth = 1
            
            view.addSubview(label)
            
            label.frame = adaptive.frames[i]
        }
        
    }
    
    func setupAdaptive(adaptiveArray:[String]) ->DZMAdaptive {
        
        let adaptive = DZMAdaptive()
        // 字符串label
        adaptive.adaptiveArray = adaptiveArray
        // 跟外面显示控件用的一样字体
        adaptive.font = UIFont.systemFontOfSize(20)
        // 这些子元素显示的父控件的最大宽度 放在哪个view上就传哪个宽度
        adaptive.maxWidth = UIScreen.mainScreen().bounds.size.width
        // 子元素之间的中间间距
        adaptive.subSpaceW = 10
        // 子元素之间的上下间距
        adaptive.subSpaceH = 10
        // 子元素内部 文字离四周的间距
        adaptive.subInset = UIEdgeInsetsMake(10, 10, 10, 10)
        // 所有子元显示素控件 离父控件四周的间距
        adaptive.inset = UIEdgeInsetsMake(60, 60, 10, 10)
        // 计算字符串约束 （view总宽度 - 距离左右的间距 - 子元素控件内部左右间距 = 得到能够显示字体的实际宽度)
        adaptive.constrainedToSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width - adaptive.inset.left - adaptive.inset.right - adaptive.subInset.left - adaptive.subInset.right , CGFloat.max)
        // 开始计算
        adaptive.startAdaptive()
        
        return adaptive
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

