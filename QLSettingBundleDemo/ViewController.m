//
//  ViewController.m
//  QLSettingBundleDemo
//
//  Created by qiu on 2021/1/13.
//  Copyright © 2021 qiu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UILabel *label2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    label.backgroundColor = [UIColor lightGrayColor];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 400, 200, 200)];
    label2.backgroundColor = [UIColor lightGrayColor];
    label2.numberOfLines = 0;
    [self.view addSubview:label2];
    
    _label = label;
    _label2 = label2;
    
    [self getBundleFile];
}

- (void)getBundleFile{
    //获取SettingsBundle信息
    // 此处的 “kMPSelectedEnvironment” 是在 “Service.plist”中设置的，请一一对应
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[userDefaults objectForKey:@"kMPSelectedEnvironment"]);
    
    
    // 取出对应的文件
    NSString *settingStr = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    NSString *fileStr = [[NSBundle bundleWithPath:settingStr] pathForResource:@"UAT" ofType:@"config"];
    NSError *error2 = nil;
    // 方式1：获取字符串
    NSString *str = [NSString stringWithContentsOfFile:fileStr encoding:NSUTF8StringEncoding error:&error2];
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    // 获取字典
    NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error2];
    
    //方式2：
    NSData *strData = [NSData dataWithContentsOfFile:fileStr];
    NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:&error2];
    
    //
    NSLog(@">>>>\n str == %@,,\n dic1 == %@ ,,\n dic2 == %@",str ,dic1 ,dic2);
    
    self.label.text = [NSString stringWithFormat:@"%@",[userDefaults objectForKey:@"kMPSelectedEnvironment"]];
    self.label2.text = [NSString stringWithFormat:@"%@",dic2];
}


@end
