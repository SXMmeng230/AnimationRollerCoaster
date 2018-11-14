//
//  ViewController.m
//  AnimationRollerCoaster
//
//  Created by 小萌 on 2018/7/23.
//  Copyright © 2018年 sunxm. All rights reserved.
//

#import "ViewController.h"
#define  WIDTH self.baseLayer.bounds.size.width
#define  HEIGHT self.baseLayer.bounds.size.height

@interface ViewController ()
@property (nonatomic, strong) CALayer *baseLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view.layer addSublayer:self.baseLayer];
    // Do any additional setup after loading the view, typically from a nib.
    //天空
    [self drawSky];
    // 白云
    [self drawCloud];
    //雪山
    [self drawSnowMountain];
    //草坪
    [self drawLawn];
   
    //轨道2
    [self drawSubway2];
    
    //轨道1
    [self drawSubway1];
    //小树
    [self drawTree];
    //人行道
    [self drawRun];
}
- (CALayer *)baseLayer
{
    if (!_baseLayer) {
        _baseLayer = [[CALayer alloc] init];
        _baseLayer.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height - 50);
        _baseLayer.backgroundColor = [UIColor whiteColor].CGColor;
    }
    return _baseLayer;
}
- (void)drawRun
{
    CALayer *groundLayer = [[CALayer alloc] init];
    groundLayer.frame = CGRectMake(0, HEIGHT - 20, WIDTH, 20);
    groundLayer.contents =(__bridge id _Nullable)([UIImage imageNamed:@"ground"].CGImage);
    [self.baseLayer addSublayer:groundLayer];

}
- (void)drawSky
{
    CAGradientLayer *skyLayer = [[CAGradientLayer alloc] init];
    skyLayer.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    skyLayer.backgroundColor = [UIColor redColor].CGColor;
//    skyLayer.locations = @[@0,@0.6,@1];
    UIColor *lightColor = [UIColor colorWithRed:40.0 / 255.0 green:150.0 / 255.0 blue:200.0 / 255.0 alpha:1.0];
    UIColor *darkColor = [UIColor colorWithRed:255.0 / 255.0 green:250.0 / 255.0 blue:250.0 / 255.0 alpha:1.0];
    skyLayer.startPoint = CGPointMake(0, 0);
    skyLayer.endPoint = CGPointMake(1, 1);
    skyLayer.colors = @[(__bridge id)lightColor.CGColor,(__bridge id)darkColor.CGColor];
    [self.baseLayer addSublayer:skyLayer];
}
- (void)drawCloud
{
    CALayer *cloudLayer = [[CALayer alloc] init];
    UIImage *clound = [UIImage imageNamed:@"cloud"];
    cloudLayer.frame = CGRectMake(WIDTH + 20, 100, clound.size.width, clound.size.height);
    cloudLayer.contents = (__bridge id _Nullable)(clound.CGImage);
    [self.baseLayer addSublayer:cloudLayer];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    basicAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(WIDTH + 10, 100)];
    basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(-30, 100)];;
    basicAnimation.duration = 9;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    basicAnimation.repeatCount = CGFLOAT_MAX;
    [cloudLayer addAnimation:basicAnimation forKey:@"translate"];
    
}
- (void)drawLawn
{
    //左边小草坪
    CAShapeLayer *samllLawnLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *samllPath = [UIBezierPath bezierPath];
    [samllPath moveToPoint:CGPointMake(0, HEIGHT - 60 - 20)];
    [samllPath addQuadCurveToPoint:CGPointMake(WIDTH / 3, HEIGHT - 50) controlPoint:CGPointMake(WIDTH / 5, HEIGHT - 60 - 20)];
    [samllPath addLineToPoint:CGPointMake(0, HEIGHT - 20)];
    [samllPath closePath];
    samllLawnLayer.path = samllPath.CGPath;
    samllLawnLayer.fillColor = [UIColor colorWithDisplayP3Red:82.0 / 255.0 green:177.0 / 255.0 blue:52.0 / 255.0 alpha:1.0].CGColor;
    [self.baseLayer addSublayer:samllLawnLayer];

    //右边大草坪
    CAShapeLayer *bigLawnLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *bigPath = [UIBezierPath bezierPath];
    [bigPath moveToPoint:CGPointMake(0, HEIGHT - 20)];
    [bigPath addQuadCurveToPoint:CGPointMake(WIDTH, HEIGHT - 60 -20) controlPoint:CGPointMake(WIDTH + 20, HEIGHT - 100 - 20)];
    [bigPath addLineToPoint:CGPointMake(WIDTH, HEIGHT - 20)];
    [bigPath closePath];
    bigLawnLayer.path = bigPath.CGPath;
    bigLawnLayer.fillColor = [UIColor colorWithDisplayP3Red:92.0/255.0 green:195.0/255.0 blue:52.0/255.0 alpha:1.0].CGColor;
    [self.baseLayer addSublayer:bigLawnLayer];
    
}

- (void)drawTree
{
    [self creatTreeWithCount:4 y:HEIGHT];
    [self creatTreeWithCount:3 y:HEIGHT - 30];
    [self creatTreeWithCount:2 y:HEIGHT - 60];
}
- (void)creatTreeWithCount:(int) count y:(CGFloat)y
{
    UIImage *tree = [UIImage imageNamed:@"tree"];
    for (int i = 0; i < count; i ++) {
        CALayer *treeLayer = [[CALayer alloc] init];
        int rang = (arc4random_uniform(WIDTH - 10) + 10);
        
        treeLayer.frame = CGRectMake(rang, y- tree.size.height - 20, tree.size.width, tree.size.height);
        treeLayer.contents =(__bridge id _Nullable)(tree.CGImage);
        [self.baseLayer addSublayer:treeLayer];
    }
}
- (void)drawSnowMountain
{
    CAShapeLayer *bigSnow = [[CAShapeLayer alloc] init];
    UIBezierPath *bigPath = [UIBezierPath bezierPath];
    [bigPath moveToPoint:CGPointMake(-20, HEIGHT - 80)];
    [bigPath addLineToPoint:CGPointMake(WIDTH / 5, HEIGHT - 300)];
    [bigPath addLineToPoint:CGPointMake(WIDTH - 100, HEIGHT - 20)];
    bigSnow.path = bigPath.CGPath;
    bigSnow.fillColor = [UIColor whiteColor].CGColor;
    [self.baseLayer addSublayer:bigSnow];

    CGFloat bigKey = (300 -80) / (WIDTH/5 + 20);
    CGFloat keyHeight = HEIGHT - 80 - bigKey * 40;
    
    
    CAShapeLayer *bigSnowColor = [[CAShapeLayer alloc] init];
    UIBezierPath *bigColorPath = [UIBezierPath bezierPath];
    [bigColorPath moveToPoint:CGPointMake(-20, HEIGHT - 80)];
    [bigColorPath addLineToPoint:CGPointMake(20, keyHeight)];
    [bigColorPath addLineToPoint:CGPointMake(50, keyHeight)];
    [bigColorPath addLineToPoint:CGPointMake(100, keyHeight + 20)];
    [bigColorPath addLineToPoint:CGPointMake(120, keyHeight)];
    [bigColorPath addLineToPoint:CGPointMake(130, keyHeight - 10)];
    CGFloat endX =WIDTH -100 -  (WIDTH -100 - WIDTH / 5) *(HEIGHT - 20 - keyHeight)/ 280.0;
    [bigColorPath addLineToPoint:CGPointMake(endX, keyHeight)];
    [bigColorPath addLineToPoint:CGPointMake(WIDTH - 100, HEIGHT - 20)];
    [bigColorPath closePath];
    bigSnowColor.path = bigColorPath.CGPath;
    bigSnowColor.fillColor = [UIColor colorWithDisplayP3Red:125.0 /255.0 green:87.0 /255.0 blue:7.0 /255.0 alpha:1.0].CGColor;
    [self.baseLayer addSublayer:bigSnowColor];
}
- (void)drawSubway1
{
    CAShapeLayer *subwayLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *subwayPath = [UIBezierPath bezierPath];
    [subwayPath moveToPoint:CGPointMake(-60, HEIGHT -10)];
    [subwayPath addCurveToPoint:CGPointMake(WIDTH * 3 / 4, HEIGHT - 60) controlPoint1:CGPointMake(WIDTH / 6, HEIGHT - 200) controlPoint2:CGPointMake(WIDTH  / 2, HEIGHT - 50)];
    
    UIBezierPath *subCrPath = [UIBezierPath bezierPath];
    [subCrPath addArcWithCenter:CGPointMake(WIDTH * 3 / 4, HEIGHT - 60 - 50) radius:50 startAngle:M_PI * 0.5 endAngle:-M_PI *2 * 3/4 clockwise:NO];

    //转一圈
    [subwayPath appendPath:subCrPath];
    
    UIBezierPath *subRightPath = [UIBezierPath bezierPath];
    [subRightPath moveToPoint:CGPointMake(WIDTH * 3 / 4, HEIGHT -60)];
    [subRightPath addQuadCurveToPoint:CGPointMake(WIDTH + 20, HEIGHT - 10) controlPoint:CGPointMake(WIDTH - 50, HEIGHT- 60 -100)];
    [subRightPath addLineToPoint:CGPointMake(-60, HEIGHT -10)];
    //转二圈
    [subwayPath appendPath:subCrPath];
    [subwayPath appendPath:subRightPath];
    subwayLayer.lineWidth = 5;
    subwayLayer.strokeColor = [UIColor colorWithDisplayP3Red:0.0 / 255.0 green:147.0 / 255.0 blue:163.0 /255.0  alpha:1.0].CGColor;
    subwayLayer.fillColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"green"]].CGColor;
    subwayLayer.path = subwayPath.CGPath;
    [self.baseLayer addSublayer:subwayLayer];
    
    CAShapeLayer *dasLayer = [[CAShapeLayer alloc] init];
    dasLayer.lineDashPattern = @[@5,@5];
    dasLayer.lineWidth = 3;
    dasLayer.strokeColor = [UIColor whiteColor].CGColor;
    dasLayer.fillColor = [UIColor clearColor].CGColor;
    dasLayer.path = subwayPath.CGPath;
    dasLayer.lineCap = kCALineCapRound;
    [subwayLayer addSublayer:dasLayer];
    
    
    [subwayLayer addSublayer:[self animationWithImage:@"car" path:subwayPath duration:12]];

    
}
- (void)drawSubway2
{
    CAShapeLayer *subwayYellowLayer = [[CAShapeLayer alloc] init];
    subwayYellowLayer.lineWidth = 5;
    subwayYellowLayer.lineCap = kCALineCapRound;
    subwayYellowLayer.strokeColor = [UIColor colorWithDisplayP3Red:210.0 / 255.0 green:179.0 / 255.0 blue:54.0 / 255.0 alpha:1.0].CGColor;
    subwayYellowLayer.fillColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow"]].CGColor;
    UIBezierPath *yellowPath = [UIBezierPath bezierPath];
    [yellowPath moveToPoint:CGPointMake(-30, HEIGHT - 10)];
    [yellowPath addCurveToPoint:CGPointMake(WIDTH * 0.5, HEIGHT - 60-100) controlPoint1:CGPointMake(WIDTH / 6, HEIGHT - 150) controlPoint2:CGPointMake(WIDTH / 3, HEIGHT + 50)];
    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    [rightPath moveToPoint:CGPointMake(WIDTH * 0.5, HEIGHT - 60-100)];
    [rightPath addQuadCurveToPoint:CGPointMake(WIDTH + 20, HEIGHT - 300) controlPoint:CGPointMake(WIDTH * 0.5 + 10, HEIGHT - 400)];
    [rightPath addLineToPoint:CGPointMake(WIDTH + 20, HEIGHT - 10)];
    [rightPath addLineToPoint:CGPointMake(-30, HEIGHT - 10)];
    [yellowPath appendPath:rightPath];
    subwayYellowLayer.path = yellowPath.CGPath;
    
//    subwayYellowLayer.fillRule = kCAFillRuleEvenOdd;

    [self.baseLayer addSublayer:subwayYellowLayer];
    
    CAShapeLayer *dasLayer = [[CAShapeLayer alloc] init];
    dasLayer.lineDashPattern = @[@5,@5];
    dasLayer.lineWidth = 3;
    dasLayer.strokeColor = [UIColor whiteColor].CGColor;
    dasLayer.fillColor = [UIColor clearColor].CGColor;
    dasLayer.path = yellowPath.CGPath;
    dasLayer.lineCap = kCALineCapRound;
    [subwayYellowLayer addSublayer:dasLayer];
    
    [subwayYellowLayer addSublayer:[self animationWithImage:@"car" path:yellowPath duration:8]];


}
- (CALayer *)animationWithImage:(NSString *)car path:(UIBezierPath *)path duration:(CGFloat)duration
{
    CALayer *carLayer = [[CALayer alloc] init];
    UIImage *carImage = [UIImage imageNamed:car];
    carLayer.bounds = CGRectMake(0, 0, carImage.size.width, carImage.size.height);
    carLayer.contents = (__bridge id _Nullable)(carImage.CGImage);
    
    CAKeyframeAnimation *yellowAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    yellowAnimation.path = path.CGPath;
    yellowAnimation.duration = duration;
    yellowAnimation.autoreverses = NO;
    yellowAnimation.calculationMode = kCAAnimationPaced;
    yellowAnimation.rotationMode = kCAAnimationRotateAuto;
    yellowAnimation.repeatCount = CGFLOAT_MAX;
    [carLayer addAnimation:yellowAnimation forKey:@"positon"];
    return carLayer;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
