//
//  TagViewController.m
//  标签切换PageVC
//
//  Created by bcmac3 on 16/6/8.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "TagViewController.h"

@interface TagViewController ()<UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%2zd行", indexPath.row];
    return cell;
}



@end
