//
//  ViewController.m
//  CJScanViewDemo
//
//  Created by Jarvis on 15/6/19.
//  Copyright (c) 2015年 Jarvis. All rights reserved.
//

#import "ViewController.h"
#import <CJScanView/ScanViewController.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (IBAction)onClickScan:(id)sender {
    
    ScanViewController * scanViewController = [[ScanViewController alloc] initWithNibName:@"ScanViewController" bundle:[NSBundle bundleForClass:[ScanViewController class]]];
    
    [self presentViewController:scanViewController animated:YES completion:nil];
}

@end
