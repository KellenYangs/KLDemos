//
//  JMBAttributedStringBuilder.h
//  MyAttributedStringDemo
//
//  Created by oybq on 15/6/18.
//  qq:156355113
//  e-mail:obq0387_cn@sina.com
//  Copyright (c) 2015年 youngsoft. All rself = [self init]ights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class KLAttributedStringBuilder;

#pragma mark - 属性字符串区域
@interface KLAttributedStringRange : NSObject

/** 字体 */
- (KLAttributedStringRange *)setFont:(UIFont *)font;
/** 文字颜色 */
- (KLAttributedStringRange *)setTextColor:(UIColor *)color;
/** 背景色 */
- (KLAttributedStringRange *)setBackgroundColor:(UIColor *)color;
/** 背景色 */
- (KLAttributedStringRange *)setParagraphStyle:(NSParagraphStyle *)paragraphStyle;
/** 连体字符，好像没有什么作用 */
- (KLAttributedStringRange *)setLigature:(BOOL)ligature;
/** 字间距 */
- (KLAttributedStringRange *)setKern:(CGFloat)kern;
/** 行间距 */
- (KLAttributedStringRange *)setLineSpacing:(CGFloat)lineSpacing;
/** 删除线 */
- (KLAttributedStringRange *)setStrikethroughStyle:(int)strikethroughStyle;
/** 删除线颜色 */
- (KLAttributedStringRange *)setStrikethroughColor:(UIColor *)StrikethroughColor NS_AVAILABLE_IOS(7_0);
/** 下划线 */
- (KLAttributedStringRange *)setUnderlineStyle:(NSUnderlineStyle)underlineStyle;
/** 下划线颜色 */
- (KLAttributedStringRange *)setUnderlineColor:(UIColor *)underlineColor NS_AVAILABLE_IOS(7_0);
/** 阴影 */
- (KLAttributedStringRange *)setShadow:(NSShadow *)shadow;
/***/
- (KLAttributedStringRange *)setTextEffect:(NSString *)textEffect NS_AVAILABLE_IOS(7_0);
/** 将区域中的特殊字符: NSAttachmentCharacter,替换为attachement中指定的图片,这个来实现图片混排。 */
- (KLAttributedStringRange *)setAttachment:(NSTextAttachment *)attachment NS_AVAILABLE_IOS(7_0);
/** 设置区域内的文字点击后打开的链接 */
- (KLAttributedStringRange *)setLink:(NSURL *)url NS_AVAILABLE_IOS(7_0);
/** 设置基线的偏移量，正值为往上，负值为往下，可以用于控制UILabel的居顶或者居低显示 */
- (KLAttributedStringRange *)setBaselineOffset:(CGFloat)baselineOffset NS_AVAILABLE_IOS(7_0);
/** 设置倾斜度 */
- (KLAttributedStringRange *)setObliqueness:(CGFloat)obliqueness NS_AVAILABLE_IOS(7_0);
/** 压缩文字，正值为伸，负值为缩 */
- (KLAttributedStringRange *)setExpansion:(CGFloat)expansion NS_AVAILABLE_IOS(7_0);  //
/** 中空文字的颜色 */
- (KLAttributedStringRange *)setStrokeColor:(UIColor *)strokeColor;
/** 中空的线宽度 */
- (KLAttributedStringRange *)setStrokeWidth:(CGFloat)strokeWidth;

//可以设置多个属性
- (KLAttributedStringRange *)setAttributes:(NSDictionary *)dict;

//得到构建器
- (KLAttributedStringBuilder *)builder;

@end


#pragma mark - 属性字符串构建器
@interface KLAttributedStringBuilder : NSObject
/**
 *  便利构造器
 */
+ (instancetype)builderWith:(NSString *)string;
- (instancetype)initWithString:(NSString *)string;

#pragma mark -- 区域
/** 指定区域,如果没有属性串或者字符串为nil则返回nil,下面方法一样。*/
- (KLAttributedStringRange *)range:(NSRange)range;
/** 全部字符 */
- (KLAttributedStringRange *)allRange;
/** 最后一个字符 */
- (KLAttributedStringRange *)lastRange;
/** 最后N个字符 */
- (KLAttributedStringRange *)lastNRange:(NSInteger)length;
/** 第一个字符 */
- (KLAttributedStringRange *)firstRange;
/** 前面N个字符 */
- (KLAttributedStringRange *)firstNRange:(NSInteger)length;
/** 用于选择特殊的字符 */
- (KLAttributedStringRange *)characterSet:(NSCharacterSet*)characterSet;
/** 用于选择特殊的字符串 */
- (KLAttributedStringRange *)includeString:(NSString*)includeString all:(BOOL)all;
/** 正则表达式 */
- (KLAttributedStringRange *)regularExpression:(NSString*)regularExpression all:(BOOL)all;


//段落处理,以\n结尾为一段，如果没有段落则返回nil
- (KLAttributedStringRange *)firstParagraph;
- (KLAttributedStringRange *)nextParagraph;


//插入，如果为0则是头部，如果为-1则是尾部
- (void)insert:(NSInteger)pos attrstring:(NSAttributedString*)attrstring;
- (void)insert:(NSInteger)pos attrBuilder:(KLAttributedStringBuilder*)attrBuilder;

- (NSAttributedString*)commit;

@end
