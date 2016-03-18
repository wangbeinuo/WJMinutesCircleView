//
//  FFProgressView.m
//  FanFan
//
//  Created by 王娟 on 16/3/2.
//  Copyright © 2016年 wang.com. All rights reserved.
//

#import "FFProgressView.h"

@implementation FFProgressView

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path
     addArcWithCenter:CGPointMake(rect.size.width * 0.5, rect.size.width * 0.5)
     radius:self.radius
     startAngle:2 * M_PI - M_PI_2
     endAngle:(2 * M_PI) * self.progress - M_PI_2
     clockwise:0];
    [path setLineWidth:2*kScaleW];
    [[UIColor orangeColor] set];
    [path stroke];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
