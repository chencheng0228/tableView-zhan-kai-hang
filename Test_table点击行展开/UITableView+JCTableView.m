//
//  UITableView+JCTableView.m
//  Test_table点击行展开
//
//  Created by admin on 15-3-3.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import "UITableView+JCTableView.h"

@implementation UITableView (JCTableView)


-(void)clearLine
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
    
}

-(void)clearBackGroundColor
{
    self.backgroundView = nil;
    self.backgroundColor = [UIColor clearColor];
}

@end
