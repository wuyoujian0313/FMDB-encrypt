//
//  ViewController.m
//  FMDB-encrypt
//
//  Created by wuyj on 14-10-12.
//  Copyright (c) 2014年 baidu. All rights reserved.
//

#import "ViewController.h"
#import "DBManger.h"

@interface ViewController ()

@property(nonatomic,strong)DBManger * dbMgr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn1 setBackgroundColor:[UIColor grayColor]];
    [btn1 setFrame:CGRectMake(40, 80, 100, 25)];
    [btn1 setTitle:@"Insert" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(dbAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTag:100];
    
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn2 setBackgroundColor:[UIColor grayColor]];
    [btn2 setFrame:CGRectMake(40, 120, 100, 25)];
    [btn2 setTitle:@"Close" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(dbAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTag:101];
    
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn3 setBackgroundColor:[UIColor grayColor]];
    [btn3 setFrame:CGRectMake(40, 180, 100, 25)];
    [btn3 setTitle:@"Get_PW" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(dbAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTag:102];
    
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn4 setBackgroundColor:[UIColor grayColor]];
    [btn4 setFrame:CGRectMake(40, 220, 100, 25)];
    [btn4 setTitle:@"Get_noPW" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(dbAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn4 setTag:103];
    
    [self.view addSubview:btn4];
    
    self.dbMgr = [[DBManger alloc] init];
   
    [self.dbMgr createTable];
}

-(void)dbAction:(UIButton*)sender{
    NSInteger tag = sender.tag;
    if (tag == 100) {
        
       
        People* p = [[People alloc] init];
        p.peopleID = 100;
        p.age = 20;
        p.name = @"wuyoujian";
        
        [_dbMgr insertPeople:p];
        
        People* p1 = [[People alloc] init];
        p1.peopleID = 101;
        p1.age = 21;
        p1.name = @"beijing";
        
        [_dbMgr insertPeople:p1];
        
    }else if(tag == 101){
        [_dbMgr closeDB];
    }else if (tag== 102){
        NSArray *arr = [_dbMgr getAllPeople];
        NSLog(@"%@",arr);
        
        for (People * p in arr) {
            NSLog(@"Have PW peopleID:%ld;\n Name:%@;\n Age:%ld",p.peopleID,p.name,p.age);
        }
    }else if (tag== 103){
        NSArray *arr = [_dbMgr getAllPeople_test];
        NSLog(@"%@",arr);
        
        for (People * p in arr) {
            NSLog(@"No PW peopleID:%ld;\n Name:%@;\n Age:%ld",p.peopleID,p.name,p.age);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
