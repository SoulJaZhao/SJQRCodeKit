//
//  SJViewController.m
//  SJQRCodeKit
//
//  Created by SoulJaGo on 08/05/2017.
//  Copyright (c) 2017 SoulJaGo. All rights reserved.
//

#import "SJViewController.h"
#import "SJScanViewController.h"
#import "SJCreateQRCodeViewController.h"
#import "SJReadQRCodeViewController.h"

@interface SJViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation SJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"SJQRCodeKitDemo";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"扫描二维码";
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"成成二维码";
    }
    else {
        cell.textLabel.text = @"识别二维码";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //扫描二维码
    if (indexPath.row == 0) {
        SJScanViewController *scanVC = [[SJScanViewController alloc] init];
        [self.navigationController pushViewController:scanVC animated:YES];
    }
    //生成二维码
    else if (indexPath.row == 1) {
        SJCreateQRCodeViewController *createVC = [[SJCreateQRCodeViewController alloc] init];
        [self.navigationController pushViewController:createVC animated:YES];
    }
    //识别二维码
    else if (indexPath.row == 2) {
        SJReadQRCodeViewController *readVC = [[SJReadQRCodeViewController alloc] init];
        [self.navigationController pushViewController:readVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
