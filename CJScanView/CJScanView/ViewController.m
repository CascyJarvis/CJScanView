//
//  ViewController.m
//  CJScanView
//
//  Created by Jarvis on 15/6/12.
//  Copyright (c) 2015年 Jarvis. All rights reserved.
//

#import "ViewController.h"
#import "ScanViewController.h"
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

- (IBAction)onPushScanView:(id)sender {
    ScanViewController * controller = [[ScanViewController alloc]initWithNibName:@"ScanViewController" bundle:nil];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
