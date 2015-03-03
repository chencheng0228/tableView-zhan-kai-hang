//
//  ViewController.m
//  Test_table点击行展开
//
//  Created by admin on 15-3-3.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+JCTableView.h"
#import "JCTableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSString *timeLength;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self makeTableView];
    
}

-(void)loadData
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:@"timeChange" object:nil];
    
    self.dataArray = [NSMutableArray arrayWithArray:@[@"主题"]];
}

-(void)makeTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30,self.view.frame.size.width, self.view.frame.size.height-30) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView clearLine];
    [self.tableView clearBackGroundColor];
    
    [self.view addSubview:self.tableView];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = self.dataArray[indexPath.row];
    if (![str isEqual:@"时长选者"]) {
        return 44;
    }
    else{
        return 200;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = self.dataArray[indexPath.row];
    
    if ([str isEqual:@"时长选者"]) {
        static NSString *jcIndertifer = @"myCell";
        JCTableViewCell *cell = (JCTableViewCell *)[tableView dequeueReusableCellWithIdentifier:jcIndertifer];
        if (cell==nil) {
            cell = [[JCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:jcIndertifer];
        }
        return cell;
    }
    
    else{
        static NSString *indertifer = @"jcCell";
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:indertifer];
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indertifer];
        }
        cell.textLabel.text = self.timeLength;
        return cell;
    }
    
   
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [self.dataArray objectAtIndex:indexPath.row];
    if (![str isEqual:@"时长选者"]) {
        if ([self isIncludeObc:@"时长选者"]) {
           
            [self.dataArray removeObject:@"时长选者"];
        }
        else {
             NSLog(@"no");
            [self.dataArray insertObject:@"时长选者" atIndex:indexPath.row+1];
        }
       //刷新。。。。
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)change:(id)sender
{
    NSNotification *noti = (NSNotification *)sender;
    NSIndexPath *patn = noti.object;
    
    self.timeLength = [NSString stringWithFormat:@"%d小时%d分钟",(int)patn.section,(int)patn.row];
    [self.tableView reloadData];
}


-(BOOL)isIncludeObc:(NSString *)str
{  int m = 0;
    for (NSString *std in self.dataArray) {
        if ([std isEqual:str]) {
            m = 1;
        }
        
    }
    if (m==1) {
        return YES;
    }
    else{
        return NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
