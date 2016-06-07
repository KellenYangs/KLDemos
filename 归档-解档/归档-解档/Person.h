//
//  Person.h
//  归档-解档
//
//  Created by bcmac3 on 16/5/25.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Man.h"

@interface Person : NSObject

@property(nonatomic,copy  ) NSString            *str;
@property(nonatomic,strong) NSMutableString     *mStr;
@property(nonatomic,copy  ) NSArray             *arr;
@property(nonatomic,strong) NSMutableArray      *mArr;
@property(nonatomic,copy  ) NSDictionary        *dic;
@property(nonatomic,strong) NSMutableDictionary *mDic;
@property(nonatomic,copy  ) NSSet               *set;
@property(nonatomic,strong) NSMutableSet        *mSet;
@property(nonatomic,copy  ) NSData              *data;
@property(nonatomic,strong) NSMutableData       *mData;

@property(nonatomic,assign) NSInteger    p_integer;
@property(nonatomic,assign) NSUInteger   p_uinteger;
@property(nonatomic,assign) CGFloat      p_cgfloat;
@property(nonatomic,assign) BOOL         p_bool;
@property(nonatomic,assign) int          p_int;
@property(nonatomic,assign) double       p_doule;
@property(nonatomic,assign) float        p_float;

@property(nonatomic,strong)Man * man;

@end
