//
//  DZMAdaptive.swift
//  标签(Label)自适应布局
//
//  Created by haspay on 16/4/6.
//  Copyright © 2016年 DZM. All rights reserved.
//

import UIKit

class DZMAdaptive: NSObject {
    
    /* 说明: (语言版本: swift 2.2 ,支持环境: >=ios7) 先设置好属性  最后调用startAdaptive()方法开始计算  计算之后通过属性获取结果
     
     富文本计算： 如果需要计算富文本 修改以下：
     1. adaptiveArray 改为AttributedString
     2. startAdaptive() 方法中 计算单个字符串大小 改为 AttributedString 的计算方式即可
     
     或者自定义模型计算:
     1. adaptiveArray 改为模型数组
     2. startAdaptive() 方法中 计算单个字符串大小 改为 模型计算
     */
    
    
    // MARK: ------------------- Main 必须设置的属性
    
    /// 需要自适应的字符串数组 (必传)
    var adaptiveArray:[String]! = []
    
    /// 计算单个子元素size时的宽高约束 (必传)
    var constrainedToSize:CGSize!
    
    /// 字体 (必传)
    var font:UIFont!
    
    /// 所有子元素排列的最大范围 宽度,可传父显示控件的宽度,用于局限子元素 (可选) default: CGFloat.max
    var maxWidth:CGFloat! = CGFloat.max
    
    /// 子元素之间的间距宽,中间间距 (可选) default: 0
    var subSpaceW:CGFloat! = 0
    
    /// 子元素之间的间距高,上下间距 (可选) default: 0
    var subSpaceH:CGFloat! = 0
    
    /// 子元素内部四周间距 (可选) default: UIEdgeInsetsMake(0, 0, 0, 0)
    var subInset:UIEdgeInsets! = UIEdgeInsetsMake(0, 0, 0, 0)
    
    /// 离父控件四周间距 (可选) default: UIEdgeInsetsMake(0, 0, 0, 0)
    var inset:UIEdgeInsets! = UIEdgeInsetsMake(0, 0, 0, 0)
    
    
    
    
    // MARK: ------------------- 使用属性 计算完毕之后得到的可供获取使用的属性
    
    /// 计算之后得到的frame数组
    var frames:[CGRect]! = []
    
    /// 计算之后得到的最大 maxY 也就是当前计算frame中的最后一个frame的最大Y值 可用于做父控件的高度
    var maxH:CGFloat! = 0
    
    
    
    
    
    // MARK: ------------------- 设置好属性  最后调用开始方法进行计算
    
    /// 开始计算
    func startAdaptive() {
        
        if !adaptiveArray.isEmpty {
            
            // x y
            var adaptiveSubX = inset.left
            var adaptiveSubY = inset.top
            
            // lastFrame
            var lastFrame:CGRect = CGRectMake(adaptiveSubX, adaptiveSubY, 0, 0)
            
            // 遍历计算
            for i in 0 ..< adaptiveArray.count {
                
                // 取出单个字符串
                let adaptiveStr = adaptiveArray[i]
                
                // 计算单个字符串大小
                let adaptiveStrSize = NSString(string:adaptiveStr).boundingRectWithSize(constrainedToSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil).size
                
                // 单个元素的真实大小
                let adaptiveSubW = round(adaptiveStrSize.width + subInset.left + subInset.right)
                let adaptiveSubH = round(adaptiveStrSize.height + subInset.top + subInset.bottom)
                
                // 单个元素临时frame
                let adaptiveSubTempRect = CGRectMake(adaptiveSubX, adaptiveSubY, adaptiveSubW, adaptiveSubH)
                
                // 检查宽度是否超过最大范围
                if CGRectGetMaxX(adaptiveSubTempRect) > maxWidth {
                    adaptiveSubX = inset.left
                    adaptiveSubY = CGRectGetMaxY(lastFrame) + subSpaceH
                }
                
                // 单个元素frame
                let adaptiveSubRect = CGRectMake(adaptiveSubX, adaptiveSubY, adaptiveSubW, adaptiveSubH)
                
                // 刷新最新X lastFrame
                adaptiveSubX = CGRectGetMaxX(adaptiveSubRect) + subSpaceW
                lastFrame = adaptiveSubRect
                
                // 存储
                frames.append(adaptiveSubRect)
            }
            
            // 获取总高度 最大的Y值
            if !frames.isEmpty {maxH = CGRectGetMaxY(frames.last!) + inset.bottom}
        }
    }
}
