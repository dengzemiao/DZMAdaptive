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
        let labels = ["爱好","1","标签", "222","ASDC","asd","a","&^^%","测试","asdkjhaskdjlkas","这种情况计算出来的宽度是正确的  但是赋值text 却是直接给这个label 的 所以如果有文字超过一行的宽度的情况可以用DZMAdaptive 来计算外部view的宽度 然后包装一个 adaptive.subInset 四周间距的label"]
        
        // 获取自适应对象
        let adaptive = setupAdaptive(labels)
        
        // 假如创建的别 view 放label 使用高度可直接获取
        print(" 需要显示view高: \(adaptive.maxH)")
        
        for i in 0 ..< labels.count {
            
            let label = UILabel()
            
            label.numberOfLines = 0
            
            // 字体注意跟计算的时候使用一样
            label.font = UIFont.systemFont(ofSize: 20)
            
            label.textAlignment = NSTextAlignment.center
            
            // 两种赋值都行
            label.text = adaptive.adaptiveArray[i]
//            label.text = labels[i]
            
            label.textColor = UIColor.red
            
            label.layer.borderColor = UIColor.red.cgColor
            
            label.layer.borderWidth = 1
            
            view.addSubview(label)
            
            label.frame = adaptive.frames[i]
        }
        
    }
    
    func setupAdaptive(_ adaptiveArray:[String]) ->DZMAdaptive {
        
        let adaptive = DZMAdaptive()
        // 字符串label
        adaptive.adaptiveArray = adaptiveArray
        // 跟外面显示控件用的一样字体
        adaptive.font = UIFont.systemFont(ofSize: 20)
        // 这些子元素显示的父控件的最大宽度 放在哪个view上就传哪个宽度
        adaptive.maxWidth = UIScreen.main.bounds.size.width
        // 子元素之间的中间间距
        adaptive.subSpaceW = 10
        // 子元素之间的上下间距
        adaptive.subSpaceH = 10
        // 子元素内部 文字离四周的间距
        adaptive.subInset = UIEdgeInsetsMake(10, 10, 10, 10)
        // 所有子元显示素控件 离父控件四周的间距
        adaptive.inset = UIEdgeInsetsMake(10, 10, 10, 10)
        // 计算字符串约束 （view总宽度 - 距离左右的间距 - 子元素控件内部左右间距 = 得到能够显示字体的实际宽度)
        adaptive.constrainedToSize = CGSize(width: UIScreen.main.bounds.size.width - adaptive.inset.left - adaptive.inset.right - adaptive.subInset.left - adaptive.subInset.right , height: CGFloat.greatestFiniteMagnitude)
        // 开始计算
        adaptive.startAdaptive()
        
        return adaptive
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

