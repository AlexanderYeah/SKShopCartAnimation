//
//  ViewController.m
//  ShopCartAnimDemo
//
//  Created by Alexander on 2018/8/9.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "ViewController.h"
#import "ShopCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIImageView *shopCartView;


@property (nonatomic,strong)UIImageView *animImgView;// 做动画的imgView


@end

@implementation ViewController

#pragma mark - 0 Lazyload

- (UIImageView *)animImgView
{
	if (!_animImgView) {
		_animImgView = [[UIImageView alloc]init];
		_animImgView.frame = CGRectMake(0, 0, 40, 40);
		_animImgView.image = [UIImage imageNamed:@"beer"];
		_animImgView.layer.cornerRadius = 20;
        _animImgView.layer.masksToBounds = YES;
        [self.view addSubview:_animImgView];
	}
	return _animImgView;
}

#pragma mark - 1 LifeCycle
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self createUI];
}
#pragma mark - 2 Create UI
- (void)createUI
{
	self.tableview.rowHeight = 70;
	
	[self.tableview registerNib:[UINib nibWithNibName:@"ShopCell" bundle:nil] forCellReuseIdentifier:@"shop"];
}

#pragma mark - 3 LoadData


#pragma mark - 4 Delegate Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

	return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

	return CGFLOAT_MIN;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"shop";
	
	ShopCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
	
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	cell.cb = ^(CGPoint point) {
		//起点
        CGPoint startPoint = [tableView convertPoint:point toView:self.view];
		CGPoint controlPoint = CGPointMake(self.shopCartView.center.x, startPoint.y);
		
		//创建一个layer
		self.animImgView.hidden = NO;
        self.animImgView.layer.position = point;
        [self.view.layer addSublayer:self.animImgView.layer];
		
		//创建关键帧
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
		//当动画完成，停留到结束位置
        animation.removedOnCompletion = YES;
        animation.fillMode = kCAFillModeForwards;
		
		// 旋转动画
		CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
		anim2.toValue = [NSNumber numberWithFloat:M_PI * 4];
		anim2.removedOnCompletion = YES;
        anim2.fillMode = kCAFillModeForwards;
		
		// 动画组
		CAAnimationGroup *animGroup = [CAAnimationGroup animation];
		animGroup.animations = [NSArray arrayWithObjects:animation,anim2, nil];
		animGroup.duration = 0.7f;
		animGroup.delegate = self;
		//当方法名字遇到create,new,copy,retain，都需要管理内存
        CGMutablePathRef path = CGPathCreateMutable();
        //设置起点
        CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
        CGPathAddQuadCurveToPoint(path, NULL, controlPoint.x, controlPoint.y, self.shopCartView.center.x, self.shopCartView.center.y);
		//设置动画路径
        animation.path = path;
		//执行动画
        [self.animImgView.layer addAnimation:animGroup forKey:nil];
		//释放路径
        CGPathRelease(path);
	};
	
    return cell;
}

#pragma mark - 动画结束之后进行隐藏
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
		self.animImgView.hidden = YES;

		NSLog(@"StartShowAnimation End");
}

#pragma mark - 5 Action Response

#pragma mark - 6 Extract Method


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
