//
//  DBManger.h
//  FMDB-encrypt
//
//  Created by wuyj on 14-10-19.
//  Copyright (c) 2014年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface People : NSObject

@property(nonatomic,assign)NSInteger peopleID;
@property(nonatomic,strong)NSString* name;
@property(nonatomic,assign)NSInteger age;

@end

@interface DBManger : NSObject

@property(nonatomic,strong)FMDatabase *db;

-(NSString *)databaseFilePath;
-(BOOL)openDB;
-(BOOL)createTable;
-(void)insertPeople:(People *)aPeople;
-(NSArray *)getAllPeople;
-(void)closeDB;


-(NSArray *)getAllPeople_test;

@end
