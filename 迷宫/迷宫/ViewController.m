//
//  ViewController.m
//  迷宫
//
//  Created by 王天亮 on 2019/12/29.
//  Copyright © 2019 王天亮. All rights reserved.
//

#import "ViewController.h"
#include <stdlib.h>
struct node {
int x;
int y;
int f;
int s;
};
struct mazeNode {
    int x;
    int y;
};
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _rowInputTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, 150, 50)];
    [self.view addSubview:_rowInputTextField];
    _rowInputTextField.placeholder = @"请输入行值";
    _rowInputTextField.layer.borderWidth = 0.5;
    _rowInputTextField.layer.borderColor = [UIColor blueColor].CGColor;
    
    _columnInputTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 120, 150, 50)];
    [self.view addSubview:_columnInputTextField];
    _columnInputTextField.placeholder = @"请输入列值";
    _columnInputTextField.layer.borderWidth = 0.5;
    _columnInputTextField.layer.borderColor = [UIColor blueColor].CGColor;
    
    
//    _extanceInputTextField = [[UITextField alloc] initWithFrame:CGRectMake(210, 50, 150, 50)];
//    [self.view addSubview:_extanceInputTextField];
//    _extanceInputTextField.placeholder = @"请输入入口x,x";
//    
//    _exportInputTextField = [[UITextField alloc] initWithFrame:CGRectMake(210, 120, 150, 50)];
//    [self.view addSubview:_exportInputTextField];
//    _exportInputTextField.placeholder = @"请输入出口x,x";
    
    
    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmButton setFrame:CGRectMake(100, 200, 40, 40)];
    [self.view addSubview:_confirmButton];
    [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _confirmButton.layer.borderWidth = 0.3;
    _confirmButton.layer.borderColor = [UIColor blueColor].CGColor;
    
    [_confirmButton addTarget:self action:@selector(clickConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_rowInputTextField resignFirstResponder];
    [_columnInputTextField resignFirstResponder];
}


- (void)clickConfirmButton {
    _row = [[_rowInputTextField.text mutableCopy]intValue];
    _column = [[_columnInputTextField.text mutableCopy]intValue];
    [self growArray];
}
- (void)growArray {
    
    for (id obj in self.view.subviews) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView =(UIImageView *)obj;
            if (imageView.tag >= 100 && imageView.tag <= 250) {
                [imageView removeFromSuperview];
            }
        }
    }
    
    
    
    int flag = 101;
    _mazeMutArry = [[NSMutableArray alloc] init];
    long int trap = 0, trap2 = 0;
    int a[50][50] = {0};
    int t[100] = {0};
    int flag2 = 0;
    int *p[50];
    struct node * poter;
    for (int i =0; i < 50; i++) {
        p[i] = a[i];
    }
    
    while (1) {
        srand((unsigned)time(NULL));
        flag2 = 0;
        for (int i = 1; i <= _row; i++) {
            for (int j = 1; j < _column; j++) {
                a[i][j] = 0;
            }
        }
        for (int i = 1; i < _row * _column * 0.5; i++) {
            t[i] = 0;
        }
    for (int i = 1; i <= _row * _column * 0.5; i++) {
            
            trap = rand() % _row + 1;
            trap2 = rand() % _column + 1;
            a[trap][trap2] = 1;
            int sum = (int)((trap - 1)*_column+trap2+100);
            t[flag2++] = sum;
    }
        a[1][1] = 0;
        a[_row][_column] = 0;
        
        poter =  bfs(1, 1, p, (int)_row, (int)_column,(int)_row, (int)_column);
        if (poter[tail - 1].x == _row && poter[tail - 1].y == _column) {
            break;
        }
    }
    
    for (int i = 1; i <= _row; i++) {
        for (int j = 1; j <= _column; j++) {
            printf("%d", a[i][j]);
        }
        printf("\n");
    }
   
//    while(poter->f == 1) {
//        NSLog(@"%d ", poter->f);
//        poter = &poter[poter->f];
//    }
    
    
    
    for (int i = 0; i < _row; i++) {
        NSMutableArray *mutArray = [[NSMutableArray alloc] init];
        for (int j = 0; j < _column; j++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(25 * j + 50, 300+ i * 25, 25, 25)];
            imageView.tag = flag;
            [self.view addSubview:imageView];
            
            [mutArray addObject:imageView];
            int flag3 = 0;
            for (int k = 0; k < flag2; k++) {
                if (t[k] == flag && t[k] != 101 && t[k] != _row*_column+100) {
                imageView.backgroundColor = [UIColor blackColor];
                    flag3++;
                    break;
                }
            }
            flag++;
            if (flag3 ==0) {
                imageView.backgroundColor = [UIColor orangeColor];
            }
            imageView.layer.borderWidth = 0.2;
            imageView.layer.borderColor = [UIColor blackColor].CGColor;
        }
        [_mazeMutArry addObject:mutArray];
    }
    
   
    
    int b = tail -1;
    while (poter[b].f != 0) {
        int tx = poter[b].x;
        int ty = poter[b].y;
        UIImageView *imageView = [self.view viewWithTag:(tx - 1)*self->_column + ty + 100];
        [UIView animateWithDuration:1.5 animations:^{
            imageView.backgroundColor =[ UIColor greenColor];
        }];
        UIImageView *imageViewTemp = [self.view viewWithTag:101];
        [UIView animateWithDuration:1.5 animations:^{
            imageViewTemp.backgroundColor =[ UIColor greenColor];
        }];
        b = poter[b].f;
    }

}

struct mazeNode mazeArr[100];
int tail = 0;
struct node * bfs(int starX, int starY, int **a, int exportX, int exportY, int row, int column){
 struct node que[2501];
 int  book[51][51] = {0};
 int next[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
 int head;
tail =0;
 int k, n, m, startx, starty, p, q, tx, ty, flag;
    startx = starX;
    starty = starY;
    p = exportX;
    q = exportY;
    n = row;
    m = column;
 head = 1;
 tail = 1;
 que[tail].x = startx;
 que[tail].y = starty;
 que[tail].f = 0;
 que[tail].s = 0;
 tail++;
 book[startx][starty] = 1;
 flag = 0;
 while (head < tail) {
  for (k = 0; k <= 3; k++) {
   tx = que[head].x + next[k][0];
   ty = que[head].y + next[k][1];
   if (tx < 1 || tx >n || ty < 1 || ty > m) {
    continue;
   }
   if (a[tx][ty] == 0 && book[tx][ty] == 0) {
    book[tx][ty] = 1;
    que[tail].x = tx;
    que[tail].y = ty;
    que[tail].f = head;
    que[tail].s = que[head].s + 1;
    tail++;
   }
   if (tx == p && ty == q) {
    flag = 1;
    break;
   }
  }
  if (flag == 1) {
   break;
  }
  head++;
 }
    
    
    struct node *poter = que;
 return poter;
}

@end
