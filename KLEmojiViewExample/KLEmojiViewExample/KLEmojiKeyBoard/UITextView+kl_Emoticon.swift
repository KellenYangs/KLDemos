//
//  UITextView+kl_Emoticon.swift
//  KLEmojiViewExample
//
//  Created by bcmac3 on 16/4/6.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

extension UITextView
{
    func insertEmoticon(emoticon: KLEmoticon) {
        // 1. emoji
        if emoticon.emoji != nil {
            replaceRange(selectedTextRange!, withText: emoticon.emoji ?? "")
        }
        
        // 2.表情图片
        if emoticon.chs != nil{
            // 1. 生成一个属性文本，字体已经设置
            let imageText = KLEmoticonAttachment.emoticonString(emoticon, font: font!)
            
            // 2. 获得文本框完整的属性文本
            let strM = NSMutableAttributedString(attributedString:attributedText)
            
            // 3.替换属性文本
            strM.replaceCharactersInRange(selectedRange, withAttributedString: imageText)
            
            // 4.重新赋值
            // 4.1记录当前的位置
            let rang = selectedRange
            attributedText = strM
            // 4.2恢复之前的位置
            selectedRange = NSMakeRange(rang.location + 1, 0)
        }
    }
    
    ///  返回 textView 完整的表情字符串
    func emoticonText() -> String {
        // 定义结果字符串
        var strM = String()
        // 遍历内部细节
        attributedText.enumerateAttributesInRange(NSMakeRange(0,attributedText.length), options: NSAttributedStringEnumerationOptions(rawValue: 0)) { (dict, range, _) -> Void in
            
            // 如果字典中包含 NSAttachment key 就说明是图片
            if let attachment = dict["NSAttachment"] as? KLEmoticonAttachment
            {
                print("配图 \(attachment.chs)")
                strM += attachment.chs ?? ""
            }else {
                // 否则就是文字，利用range提取内容，拼接字符串即可
                let str = (self.attributedText.string as NSString).substringWithRange(range)
                strM += str
            }
            
        }
        print("最终结果 \(strM)")
        return strM
    }
}
