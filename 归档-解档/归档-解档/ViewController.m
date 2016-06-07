//
//  ViewController.m
//  归档-解档
//
//  Created by bcmac3 on 16/5/25.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "KLArchiver.h"

#import "KLPropertyKey.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[@"1", @"2", @"3", @"4", @"5"];
    KLPropertyKey *pk = [[KLPropertyKey alloc] init];
    pk.name = @"1";
    pk.type = KLPropertyKeyTypeArray;
    
    NSLog(@"%@", [pk valueInObject:array]);
   
}








- (void)setArchiver {
    Person * model = [[Person alloc]init];
    model.str = @"str";
    model.mStr = [NSMutableString stringWithString:@"mStr"];
    model.dic = @{@"key":@"value"};
    model.mDic = [NSMutableDictionary dictionaryWithDictionary:@{@"key":@"mValue"}];
    model.arr = @[@"arr1",@"arr2"];
    model.mArr = [NSMutableArray arrayWithArray:@[@"marr1",@"marr2"]];
    model.set = [NSSet setWithObjects:@"1",@"2",@"3",nil];
    model.mSet = [NSMutableSet setWithSet:model.set];
    model.data = [model.str dataUsingEncoding:NSUTF8StringEncoding];
    model.mData = [NSMutableData dataWithData:model.data];
    
    model.p_float = 1.1;
    model.p_doule = 2.2;
    model.p_cgfloat = 3.3;
    model.p_int = -4;
    model.p_integer = 5;
    model.p_uinteger = 6;
    model.p_bool = YES;
    
    Man * man = [[Man alloc]init];
    man.name = @"wzx";
    man.age = 23;
    man.sex = 1;
    
    model.man = man;
    
    
    BOOL isHave = [model kl_archiveToName:@"person1"];
    NSAssert(isHave = YES, @"归档失败");
    
    Person *model2 = [Person kl_unArchiveToName:@"person1"];
    model2.man = [Man kl_unArchiveSonEntityToName:KLArchiver_SonPath(@"Person", @"person1", @"Man", @"man")];
    NSLog(@"model2 - %@, man - %@",model2, model2.man);
}

@end














