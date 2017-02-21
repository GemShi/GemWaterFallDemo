//
//  ViewController.m
//  GemWaterFallDemo
//
//  Created by GemShi on 2017/2/21.
//  Copyright © 2017年 GemShi. All rights reserved.
//

#import "ViewController.h"
#import "GemWaterFallCell.h"

#define SPACE_WIDTH 10
#define TABELVIEW_WIDTH (self.view.bounds.size.width - 2 * SPACE_WIDTH) / 3

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController
{
    NSMutableArray *_dataArray;
    NSMutableArray *_threeDataArray;
    CGFloat _imageLength[3];
    NSMutableArray *_tableViewsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initData];
    [self reloadDataSource];
    [self createTableViews];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData
{
    _dataArray = [[NSMutableArray alloc]init];
    for (int  i = 0; i < 15; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%.2ld.jpg",(long)i]];
        [_dataArray addObject:image];
    }
}

-(void)reloadDataSource
{
    _threeDataArray = nil;
    for (id obj in _dataArray) {
        NSMutableArray *littleDataSource = [self shortDataSource];
        [littleDataSource addObject:obj];
        
        [self updateLengthOfLittleDataSource:littleDataSource];
    }
}

-(NSMutableArray *)shortDataSource
{
    CGFloat minLength = _imageLength[0];
    NSInteger min = 0;
    for (NSInteger i = 1; i <= 2; i++) {
        if (_imageLength[i] < minLength) {
            minLength = _imageLength[i];
            min = i;
        }
    }
    
    if (_threeDataArray == nil) {
        _threeDataArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 3; i++) {
            NSMutableArray *array = [NSMutableArray array];
            [_threeDataArray addObject:array];
        }
    }
    return _threeDataArray[min];
}

-(void)updateLengthOfLittleDataSource:(NSMutableArray *)little
{
    NSInteger index = [_threeDataArray indexOfObject:little];
    CGFloat length = [self lengthOfImage:little.lastObject];
    _imageLength[index] += length;
}

-(CGFloat)lengthOfImage:(UIImage *)image
{
    CGFloat width = TABELVIEW_WIDTH;
    CGSize imageSize = image.size;
    return imageSize.height * width / imageSize.width;
}

-(void)createTableViews
{
    _tableViewsArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < 3; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(i * (TABELVIEW_WIDTH + SPACE_WIDTH), 0, TABELVIEW_WIDTH, self.view.bounds.size.height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:tableView];
        [_tableViewsArray addObject:tableView];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger index = [_tableViewsArray indexOfObject:tableView];
    return [_threeDataArray[index] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GemWaterFallCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[GemWaterFallCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSInteger index = [_tableViewsArray indexOfObject:tableView];
    NSMutableArray *array = _threeDataArray[index];
    UIImage *image = array[indexPath.row];
    [cell setShowImage:image width:TABELVIEW_WIDTH height:[self lengthOfImage:image]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = [_tableViewsArray indexOfObject:tableView];
    NSMutableArray * array = _threeDataArray[index];
    UIImage * image = array[indexPath.row];
    
    return [self lengthOfImage:image] + SPACE_WIDTH;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    for (UITableView * tableView in _tableViewsArray) {
        if (tableView == scrollView)
            continue;
        tableView.contentOffset = offset;
    }
}

@end
