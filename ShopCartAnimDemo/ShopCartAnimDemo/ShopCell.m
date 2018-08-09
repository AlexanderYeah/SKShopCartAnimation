//
//  ShopCell.m
//  ShopCartAnimDemo
//
//  Created by Alexander on 2018/8/9.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "ShopCell.h"

@implementation ShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)addCartBtnClick:(id)sender {
	// 点击的时候 将btn 的坐标 回传到vc 做动画
	UIButton *btn = (UIButton *)sender;
	// 将坐标转化为 tableview 上单额坐标
	CGPoint point = [self convertPoint:btn.center toView:self.superview];
	if (self.cb) {
		self.cb(point);
	}
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
