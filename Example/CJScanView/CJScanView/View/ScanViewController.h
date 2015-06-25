//
//  ScanViewController.h
//  AQPresentation
//
//  Created by Jarvis on 15/5/19.
//  Copyright (c) 2015年 Jarvis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class ScanViewController;
@protocol ScanDelegate<NSObject>

@optional

- (void)ScanController:(ScanViewController *)controller ReportResult:(NSString *)string;

@end

@interface ScanViewController : UIViewController

@property (nonatomic , assign) id <ScanDelegate> delegate;

@end