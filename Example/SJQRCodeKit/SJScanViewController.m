//
//  SJScanViewController.m
//  SJQRCodeKit
//
//  Created by SoulJa on 2017/8/5.
//  Copyright © 2017年 SoulJaGo. All rights reserved.
//

#import "SJScanViewController.h"
#import <SJQRCodeKit/SJQRCodeKit.h>

@interface SJScanViewController () <SJQRCodeScanViewDelegate,UIAlertViewDelegate>
/**扫描View**/
@property (nonatomic,strong) SJQRCodeScanView *scanView;
@end

@implementation SJScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描二维码";
    //添加扫描View
    _scanView = [[SJQRCodeScanView alloc] initWithFrame:self.view.bounds];
    _scanView.scanImageView.image = [UIImage imageNamed:@"pick_bg"];
    _scanView.scanLineImageView.image = [UIImage imageNamed:@"line"];
    _scanView.delegate = self;
    [self.view addSubview:_scanView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //开始扫描
    [_scanView startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //停止扫描
    [_scanView stopRunning];
}

#pragma mark - SJQRCodeScanViewDelegate
- (void)qrCodeScanView:(SJQRCodeScanView *)scanView didScanResultString:(NSString *)resultString {
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"消息" message:resultString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alerView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [_scanView startRunning];
}

@end
