//
//  MaskView.h
//  CJScanView
//
//  Created by Jarvis on 15/6/12.
//  Copyright (c) 2015年 Jarvis. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface MaskView : UIView

//内侧间距
@property (nonatomic) IBInspectable CGFloat innerMargin;

//边框样式
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat borderLength;

//扫描框定位
@property (nonatomic) IBInspectable CGFloat leftMargin;
@property (nonatomic) IBInspectable CGFloat rightMargin;
@property (nonatomic) IBInspectable CGFloat topMargin;
@property (nonatomic) IBInspectable CGFloat aspcetRatio;//宽高比


- (CGRect) calRect;
- (CGRect) interestRect;

@end
