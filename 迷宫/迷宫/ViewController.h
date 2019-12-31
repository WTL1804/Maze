//
//  ViewController.h
//  迷宫
//
//  Created by 王天亮 on 2019/12/29.
//  Copyright © 2019 王天亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic) NSInteger row;
@property (nonatomic) NSInteger column;
@property (nonatomic) NSInteger x1;
@property (nonatomic) NSInteger y1;
@property (nonatomic) NSInteger x2;
@property (nonatomic) NSInteger y2;


@property (nonatomic, strong) UITextField *rowInputTextField;
@property (nonatomic, strong) UITextField *columnInputTextField;

@property (nonatomic, strong) UITextField *extanceInputTextField;
@property (nonatomic, strong) UITextField *exportInputTextField;

@property (nonatomic, strong) UIButton *confirmButton;


@property (nonatomic, strong) NSMutableArray *mazeMutArry;

//生成二维数组
- (void)growArray;
@end

