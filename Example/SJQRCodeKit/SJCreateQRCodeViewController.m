//
//  SJCreateQRCodeViewController.m
//  SJQRCodeKit
//
//  Created by SoulJa on 2017/8/5.
//  Copyright © 2017年 SoulJaGo. All rights reserved.
//

#import "SJCreateQRCodeViewController.h"
#import <SJQRCodeKit/SJQRCodeKit.h>

@interface SJCreateQRCodeViewController ()

@end

@implementation SJCreateQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"生成二维码";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *QRString = @"https://www.baidu.com";
    
    UIImage *QRImage = [SJQRCodeUtil createQRimageString:QRString sizeWidth:200 fillColor:[UIColor blackColor]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:QRImage];
    imageView.center = self.view.center;
    
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
