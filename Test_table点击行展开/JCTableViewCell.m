//
//  JCTableViewCell.m
//  Test_table点击行展开
//
//  Created by admin on 15-3-3.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import "JCTableViewCell.h"

@implementation JCTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews
{
    NSMutableArray *hoursAry = [NSMutableArray array];
    for (int i = 0 ; i<24; i++) {
        [hoursAry addObject:[NSString stringWithFormat:@"%d",i]];
    }
    NSMutableArray *minutesAry = [NSMutableArray array];
    for (int i = 0; i<60; i++) {
        [minutesAry addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    self.dataArray = [NSMutableArray arrayWithObjects:hoursAry,@[@"小时"],minutesAry,@[@"分钟"] ,nil];
    
    self.pickView = [[UIPickerView alloc] init];
    self.pickView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 165);
    [self.contentView addSubview:self.pickView];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    
    
    
}

#pragma pickViewDelegate-datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.dataArray.count;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.dataArray[component] count];
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSString *str = [self.dataArray[component] objectAtIndex:row];
    NSMutableAttributedString *std = [[NSMutableAttributedString alloc] initWithString:str];
    [std addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, std.length)];
    return std;
}


//获取选择的结果。。。。。。。
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==0||component==2) {
        int hourRow = (int)[pickerView selectedRowInComponent:0];
        int minuteRow =  (int)[pickerView selectedRowInComponent:2];
        
        if (row == 0) {
            if (hourRow == 0 && component == 2) {
                [pickerView selectRow:1 inComponent:component animated:YES];
                minuteRow = 1;
            }
            if (minuteRow == 0 && component == 0) {
                [pickerView selectRow:1 inComponent:component animated:YES];
                hourRow = 1;
            }
    }
        NSString *hourStr   = [self.dataArray[0] objectAtIndex:hourRow];
        NSString *minuteStr = [self.dataArray[2] objectAtIndex:minuteRow];
        NSIndexPath *path = [NSIndexPath indexPathForRow:[minuteStr integerValue] inSection:[hourStr integerValue]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"timeChange" object:path];
    }
    
    
}

@end
