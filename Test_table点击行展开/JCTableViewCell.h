//
//  JCTableViewCell.h
//  Test_table点击行展开
//
//  Created by admin on 15-3-3.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCTableViewCell : UITableViewCell<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) UIPickerView *pickView;

@property (nonatomic,strong) UILabel *lab;

@property (nonatomic,strong) NSMutableArray *dataArray;

@end
