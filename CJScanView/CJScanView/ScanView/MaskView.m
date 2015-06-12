//
//  MaskView.m
//  CJScanView
//
//  Created by Jarvis on 15/6/12.
//  Copyright (c) 2015年 Jarvis. All rights reserved.
//

#import "MaskView.h"

@implementation MaskView


- (void) drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    CGRect maskRect = [self calRect];
    
    [self drawScanRect:maskRect];
    [self clearRect:maskRect];
}

- (CGRect) calRect
{
    CGFloat x = _leftMargin;
    CGFloat y = _topMargin;
    CGFloat width = (self.bounds.size.width - _rightMargin) - _leftMargin;
    CGFloat height = width * _aspcetRatio;
    
    return CGRectMake(x, y, width, height);
}


- (CGRect) interestRect
{
    // 计算遮罩框大小
    CGRect maskRect = [self calRect];
    
    CGFloat screenWidth = self.bounds.size.width;
    CGFloat screenHeight = self.bounds.size.height;
    
    CGFloat interestX = maskRect.origin.y / screenHeight;
    CGFloat interestY = maskRect.origin.x / screenWidth;
    CGFloat interestWidth = maskRect.size.height / screenHeight;
    CGFloat interestHeight = maskRect.size.width / screenWidth;
    
    return CGRectMake(interestX, interestY, interestWidth, interestHeight);
}


- (void) drawScanRect:(CGRect )rect{
    CGFloat x = rect.origin.x + _borderWidth / 2;
    CGFloat y = rect.origin.y + _borderWidth / 2;
    CGFloat height = rect.size.height - _borderWidth;
    CGFloat width = rect.size.width - _borderWidth;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set color
    CGContextSetRGBStrokeColor(context, 0, 255, 0, 1.0);
    
    // draw stroke
    CGContextSetLineWidth(context, _borderWidth);
    CGContextSetLineJoin(context, kCGLineJoinMiter);
    
    // top left
    CGContextMoveToPoint(context, x, y + _borderLength);
    CGContextAddLineToPoint(context, x, y);
    CGContextAddLineToPoint(context, x + _borderLength, y);
    CGContextStrokePath(context);
    
    // top right
    CGContextMoveToPoint(context, x + width - _borderLength, y);
    CGContextAddLineToPoint(context, x + width, y);
    CGContextAddLineToPoint(context, x + width, y + _borderLength);
    CGContextStrokePath(context);
    
    // bottom left
    CGContextMoveToPoint(context, x, y + height - _borderLength);
    CGContextAddLineToPoint(context, x, y + height);
    CGContextAddLineToPoint(context, x + _borderLength, y + height);
    CGContextStrokePath(context);
    
    // bottom right
    CGContextMoveToPoint(context, x + width  - _borderLength, y + height);
    CGContextAddLineToPoint(context, x + width, y + height);
    CGContextAddLineToPoint(context, x + width , y + height - _borderLength);
    CGContextStrokePath(context);
}

- (void) clearRect: (CGRect ) rect {
    CGFloat clearX = rect.origin.x + _borderWidth + _innerMargin;
    CGFloat clearY = rect.origin.y + _borderWidth + _innerMargin;
    CGFloat clearWidth = rect.size.width - 2 * (_borderWidth + _innerMargin);
    CGFloat clearHeight = rect.size.height - 2 * (_borderWidth + _innerMargin);
    
    CGRect clearRect = CGRectMake(clearX , clearY, clearWidth, clearHeight);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextClearRect(context, clearRect);
}

@end
