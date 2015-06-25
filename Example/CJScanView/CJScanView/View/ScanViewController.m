//
//  ScanViewController.m
//  AQPresentation
//
//  Created by Jarvis on 15/5/19.
//  Copyright (c) 2015年 Jarvis. All rights reserved.
//

#import "ScanViewController.h"
#import "MaskView.h"
//#import "UIImage+Bundle.h"
//#import "NSBundle+Custom.h"
static const char *kScanQRCodeQueueName = "ScanQRCodeQueue";
static const float textTopMargin = 30;
static const float buttonTopMargin = 90;

@interface ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>

// Image Resource
@property (weak, nonatomic) IBOutlet UIImageView *scanLine;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;


// 扫描层
@property (weak , nonatomic) IBOutlet UIView * scanView;
@property (weak , nonatomic) IBOutlet MaskView * maskView;

// AVFoundation
@property (strong , nonatomic) AVCaptureDevice * device;
@property (strong , nonatomic) AVCaptureDeviceInput * input;
@property (strong , nonatomic) AVCaptureMetadataOutput * output;
@property (strong , nonatomic) AVCaptureSession * session;
@property (strong , nonatomic) AVCaptureVideoPreviewLayer * preview;

// 扫描线上端的距离，用于动画
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraintsLine;
@property (nonatomic) BOOL upOrDown;


// 其他控件距顶端的距离约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancelBtnConstraint;

@end

@implementation ScanViewController
                                                                     
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    _upOrDown = YES;
    
    [self setupCapture];
    [self setupConstraints];
    [self setupAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 动画代码
- (void)setupAnimation
{
    NSTimer * timer = [NSTimer timerWithTimeInterval:.02 target:self selector:@selector(lineAnimation) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)lineAnimation
{
    CGRect frameRect = [_maskView calRect];
    CGFloat margin = 10.0;
    if (_upOrDown) {
        _topConstraintsLine.constant += 2;
        if (_topConstraintsLine.constant > (frameRect.origin.y + frameRect.size.height - margin)) {
            _upOrDown = !_upOrDown;
        }
        [self.view layoutIfNeeded];
    } else {
        _topConstraintsLine.constant -= 2;
        if (_topConstraintsLine.constant < (frameRect.origin.y + margin)) {
            _upOrDown = !_upOrDown;
        }
        [self.view setNeedsDisplay];
    }
}

#pragma mark - 设置控件位置
- (void)setupConstraints
{
    CGRect frameRect = [_maskView calRect];
    CGFloat top = frameRect.origin.y + frameRect.size.height;
    
    _textConstraint.constant = top + textTopMargin;
    _cancelBtnConstraint.constant = top + buttonTopMargin;
    
    [self.view layoutIfNeeded];
}

- (IBAction)onCancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 设置二维码扫描
- (void)setupCapture
{
    // 获取 AVCptureDevice 实例
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 初始化输入流
    NSError * error;
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (!_input)
    {
        NSLog(@"Error: %@",[error localizedDescription]);
        return;
    }
    // 初始化输出流
    _output = [[AVCaptureMetadataOutput alloc] init];
    
    // 创建会话
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    // 添加输入输出流
    if ([_session canAddInput:_input]) {
        [_session addInput:_input];
    }
    
    if ([_session canAddOutput:_output]) {
        [_session addOutput:_output];
    }
    
    // 创建dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create(kScanQRCodeQueueName, NULL);
    [_output setMetadataObjectsDelegate:self queue:dispatchQueue];
    
    // 设置扫描数据类型
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    // 设置输出对象
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = _scanView.layer.bounds;
    
    // 设置扫描区域
    [_output setRectOfInterest:[_maskView interestRect]];
    
    [_scanView.layer addSublayer:_preview];
    
    // 开始会话
    [_session startRunning];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
//        [self dismissViewControllerAnimated:YES completion:nil];
        
        
        //停止扫描
        [_session stopRunning];
        _session = nil;
        
        [self performSelectorOnMainThread:@selector(reportScanResult:) withObject:stringValue waitUntilDone:NO];
    }
}

#pragma mark - Call delegate
- (void)reportScanResult:(NSString *)resultString
{
    if ([_delegate respondsToSelector:@selector(ScanController:ReportResult:)]) {
        [_delegate ScanController:self ReportResult:resultString];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
