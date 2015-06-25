//
//  UIImage+Bundle.m
//  iBeaconCardVerify
//
//  Created by Jarvis on 15/6/8.
//  Copyright (c) 2015年 Jarvis. All rights reserved.
//

#import "UIImage+Bundle.h"
#import "NSBundle+Custom.h"
@implementation UIImage (Bundle)


+ (UIImage *)imageNamedFromCustomBundle:(NSString *)imgName
{
    UIImage *imageFromMainBundle = [UIImage imageNamed:imgName];
    if (imageFromMainBundle) {
        return imageFromMainBundle;
    }
    
    UIImage *imageFromMyLibraryBundle = [UIImage imageWithContentsOfFile:[[[NSBundle CustomBundle] resourcePath] stringByAppendingPathComponent:imgName]];
    
    return imageFromMyLibraryBundle;
}

@end