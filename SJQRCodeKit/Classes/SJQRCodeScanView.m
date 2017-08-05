//
//  SJQRCodeScanView.m
//  SJQRCodeKit
//
//  Created by SoulJa on 2017/7/28.
//  Copyright © 2017年 com.shengpay.mpos.shengshua. All rights reserved.
//

#import "SJQRCodeScanView.h"
#import <AVFoundation/AVFoundation.h>

#define SJ_SCANVIEW_WIDTH_SCALE 0.7

static const int kMovePx = 2;
@interface SJQRCodeScanView() <AVCaptureMetadataOutputObjectsDelegate>
/**遮罩层**/
@property (nonatomic,strong) CAShapeLayer *shadowLayer;
/**device**/
@property (nonatomic,strong) AVCaptureDevice *device;
/**input**/
@property (nonatomic,strong) AVCaptureDeviceInput *input;
/**output**/
@property (nonatomic,strong) AVCaptureMetadataOutput *output;
/**session**/
@property (nonatomic,strong) AVCaptureSession *session;
/**preview**/
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *preview;
/**扫描定时器**/
@property (nonatomic,strong) NSTimer *scanTimer;
/**移动的次数**/
@property (nonatomic,assign) NSInteger moveCount;
@end

@implementation SJQRCodeScanView

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _moveCount = 0;
        [self setupShadowLayerWithRect:frame];
    }
    return self;
}

#pragma mark - 设置扫码
- (void)setupScanWithScanRect:(CGRect)rect {
    //Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    //Output
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置扫描区域
    CGFloat top = rect.origin.y / self.frame.size.height;
    CGFloat left = rect.origin.x / self.frame.size.width;
    CGFloat width = rect.size.width / self.frame.size.width;
    CGFloat height = rect.size.height / self.frame.size.height;
    ///top 与 left 互换  width 与 height 互换
    [_output setRectOfInterest:CGRectMake(top,left, height, width)];
    
    //Session
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    //连接输入和输出
    if ([_session canAddInput:_input]) {
        [_session addInput:_input];
    }
    
    if ([_session canAddOutput:_output]) {
        [_session addOutput:_output];
    }
    
    //设置条码类型
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    //添加扫描画面
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = self.layer.bounds;
    [self.layer insertSublayer:_preview atIndex:0];
}

#pragma mark - 设置遮罩层
- (void)setupShadowLayerWithRect:(CGRect)rect {
    //绘制遮罩层
    _shadowLayer = [CAShapeLayer layer];
    CGMutablePathRef path = CGPathCreateMutable();
    //path rect
    CGFloat widthHeight = rect.size.width * SJ_SCANVIEW_WIDTH_SCALE;
    CGFloat left = rect.size.width * (1 - SJ_SCANVIEW_WIDTH_SCALE) / 2;
    CGFloat top = (rect.size.height - widthHeight)/2;
    
    CGRect scanRect = CGRectMake(left, top, widthHeight, widthHeight);
    
    CGPathAddRect(path, nil, scanRect);
    CGPathAddRect(path, nil, rect);
    
    //添加遮罩imageView
    _scanImageView = [[UIImageView alloc] initWithFrame:scanRect];
    [self addSubview:_scanImageView];
    
    //添加line
    _scanLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scanRect.size.width, 3)];
    [_scanImageView addSubview:_scanLineImageView];
    
    //扫描动画
    _scanTimer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(scanLineMove) userInfo:nil repeats:YES];
    [_scanTimer setFireDate:[NSDate date]];
    [[NSRunLoop currentRunLoop] addTimer:_scanTimer forMode:NSRunLoopCommonModes];
    
    
    [_shadowLayer setPath:path];
    [_shadowLayer setFillRule:kCAFillRuleEvenOdd];
    [_shadowLayer setFillColor:[UIColor blackColor].CGColor];
    [_shadowLayer setOpacity:0.6];
    
    [_shadowLayer setNeedsDisplay];
    
    //清除内存
    CGPathRelease(path);
    
    [self.layer addSublayer:_shadowLayer];
    
    
    
    //设置扫码
    [self setupScanWithScanRect:scanRect];
}

#pragma mark - 扫描动画
- (void)scanLineMove {
    _moveCount++;
    if (_moveCount < _scanImageView.frame.size.height / kMovePx) {
        _scanLineImageView.frame = CGRectMake(0, _moveCount * kMovePx, _scanLineImageView.frame.size.width, _scanLineImageView.frame.size.height);
    } else {
        _moveCount = 0;
        _scanLineImageView.frame = CGRectMake(0, 0, _scanLineImageView.frame.size.width, _scanLineImageView.frame.size.height);
    }
}

#pragma mark - 绘制图形
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    

}

#pragma mark - 开始扫描
- (void)startRunning {
    if (![_session isRunning]) {
        //开始定时器
        [_scanTimer setFireDate:[NSDate date]];
        [_session startRunning];
    }
}

#pragma mark - 关闭扫描
- (void)stopRunning {
    if ([_session isRunning]) {
        //停止定时器
        [_scanTimer setFireDate:[NSDate distantFuture]];
        [_session stopRunning];
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate 扫描完成
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    //结果字符串
    NSString *stringValue;
    
    if  (metadataObjects.count > 0) {
        //停止扫描
        [self stopRunning];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
        if (_delegate && [_delegate respondsToSelector:@selector(qrCodeScanView:didScanResultString:)]) {
            [_delegate qrCodeScanView:self didScanResultString:stringValue];
        }
        
    } else {
        return;
    }
}

- (void)dealloc {
    [_scanTimer invalidate];
    _scanTimer = nil;
    _device = nil;
    _session = nil;
    //取消动画
    [self.layer removeAllAnimations];
}
@end
