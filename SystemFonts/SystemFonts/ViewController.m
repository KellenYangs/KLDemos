//
//  ViewController.m
//  SystemFonts
//
//  Created by bcmac3 on 06/02/2017.
//  Copyright © 2017 ShenYan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSDictionary *_fonts;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self prepareFonts];
}

- (void)prepareFonts {
    NSArray *familyNames = [UIFont familyNames];
    familyNames = [familyNames sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:nil ascending:YES]]];

    NSMutableDictionary *d = @{}.mutableCopy;
    for (int i = 65;i < 90 ; i++) {
        NSString *prefix = [NSString stringWithFormat:@"%c", i];
        NSMutableArray *fonts = @[].mutableCopy;
        for (NSString *fontName in familyNames) {
            if ([fontName hasPrefix:prefix]) {
                [fonts addObject:fontName];
            }
        }
        if (fonts.count > 0) {
            [d setObject:fonts forKey:prefix];
        }
    }

    _fonts = d.copy;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_fonts count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_fonts[[_fonts allKeys][section]] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_fonts allKeys][section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    NSString *fontName = _fonts[[_fonts allKeys][indexPath.section]][indexPath.row];
    cell.detailTextLabel.text = @"ShenYan Strive Strive! 努力 努力";
    cell.detailTextLabel.font = [UIFont fontWithName:fontName size:17];
    cell.textLabel.text = _fonts[[_fonts allKeys][indexPath.section]][indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:fontName size:14];
    cell.textLabel.textColor = [UIColor grayColor];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
