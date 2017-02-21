//
//  GemWaterFallCell.m
//  GemWaterFallDemo
//
//  Created by GemShi on 2017/2/21.
//  Copyright © 2017年 GemShi. All rights reserved.
//

#import "GemWaterFallCell.h"

@implementation GemWaterFallCell

{
    UIImageView * _showImageView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //创建子视图
        [self createImageView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)createImageView
{
    _showImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_showImageView];
}

- (void)setShowImage:(UIImage *)image width:(CGFloat)width height:(CGFloat)height
{
    _showImageView.image = image;
    
    //然后修改图片的大小
    _showImageView.frame = CGRectMake(0, 0, width, height);
}

@end
