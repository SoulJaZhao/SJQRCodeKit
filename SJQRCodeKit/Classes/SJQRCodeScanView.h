//
//  SJQRCodeScanView.h
//  SJQRCodeKit
//
//  Created by SoulJa on 2017/7/28.
//  Copyright © 2017年 com.shengpay.mpos.shengshua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SJQRCodeScanView;
@protocol SJQRCodeScanViewDelegate<NSObject>
- (void)qrCodeScanView:(SJQRCodeScanView *)scanView didScanResultString:(NSString *)resultString;

@end

@interface SJQRCodeScanView : UIView
/**扫描背景图**/
@property (nonatomic,strong) UIImageView *scanImageView;
/**扫描Line**/
@property (nonatomic,strong) UIImageView *scanLineImageView;
/**代理**/
@property (nonatomic,weak) id<SJQRCodeScanViewDelegate> delegate;

/**开始扫描**/
- (void)startRunning;
/**关闭扫描**/
- (void)stopRunning;

@end
