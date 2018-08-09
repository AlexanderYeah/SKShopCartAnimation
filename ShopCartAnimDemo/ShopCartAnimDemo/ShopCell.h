//
//  ShopCell.h
//  ShopCartAnimDemo
//
//  Created by Alexander on 2018/8/9.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddCartBtnClick)(CGPoint point);

@interface ShopCell : UITableViewCell

@property (nonatomic,copy)AddCartBtnClick cb;




@end
