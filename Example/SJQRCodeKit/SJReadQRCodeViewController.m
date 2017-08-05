//
//  SJReadQRCodeViewController.m
//  SJQRCodeKit
//
//  Created by SoulJa on 2017/8/5.
//  Copyright © 2017年 SoulJaGo. All rights reserved.
//

#import "SJReadQRCodeViewController.h"
#import <SJQRCodeKit/SJQRCodeKit.h>

@interface SJReadQRCodeViewController ()

@end

@implementation SJReadQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"识别二维码";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *QRString = [SJQRCodeUtil readQRCodeFromImage:[UIImage imageNamed:@"baidu"]];
    NSLog(@"%@",QRString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
