//
//  UILabel+kl_TextOfOnePointNumber.m
//  label第二行显示...
//
//  Created by bcmac3 on 16/4/19.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "UILabel+kl_TextOfOnePointNumber.h"
#import <CoreText/CoreText.h>

@implementation UILabel (kl_TextOfOnePointNumber)
- (NSString *)textOfOnePointNumber {
    NSString *text = [self text];
    UIFont   *font = [self font];
    CGRect    rect = [self frame];
    
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines){
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    //处理数组中的数据
    NSMutableString *stringLast = [NSMutableString new];
    //先判断返回的数组长度是否大于2；
    if(linesArray.count>=2){
        //判断第二行文字长度是否小于等于3
        if([linesArray[1] length]<=3){//小于等于3
            if ([linesArray[1] length]>=2) {//2 3
                stringLast = [NSMutableString stringWithFormat:@"%@%@",linesArray.firstObject,[linesArray[1] substringToIndex:[linesArray[1] length]-1]];
                [stringLast appendString:@"..."];
            }else{//1
                stringLast = [NSMutableString stringWithFormat:@"%@%@",linesArray.firstObject,linesArray[1]];
            }
        }else{//大于3
            stringLast = [NSMutableString stringWithFormat:@"%@%@",
                          linesArray.firstObject,
                          [linesArray[1] substringToIndex:[linesArray[1] length]-3]];
            [stringLast appendString:@"..."];
        }
    }else{//长度为1
        //判断文字的长度是大于3
        if([linesArray.firstObject length] > 3){
            stringLast = [NSMutableString stringWithFormat:@"%@%@",[linesArray.firstObject substringToIndex:[linesArray.firstObject length]-3],@"..."];
        }else{
            //<=3，不做任何处理
            stringLast = [NSMutableString stringWithFormat:@"%@",self.text];
        }
    }
    return stringLast;
}
@end
