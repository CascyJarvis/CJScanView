//
//  NSBundle+Custom.m
//  AQPresentation
//
//  Created by Jarvis on 15/6/8.
//  Copyright (c) 2015年 Jarvis. All rights reserved.
//

#import "NSBundle+Custom.h"

@implementation NSBundle (Custom)

+ (NSBundle*) CustomBundle {
    static dispatch_once_t onceToken;
    static NSBundle *myLibraryResourcesBundle = nil;
    dispatch_once(&onceToken, ^{
        myLibraryResourcesBundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:kBundleName withExtension:@"bundle"]];
    });
    return myLibraryResourcesBundle;
}

@end
