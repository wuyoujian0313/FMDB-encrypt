//
//  DBManger.m
//  FMDB-encrypt
//
//  Created by wuyj on 14-10-19.
//  Copyright (c) 2014年 baidu. All rights reserved.
//

#import "DBManger.h"



@implementation People
@end


@implementation DBManger

-(NSString *)databaseFilePath{
    
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    NSLog(@"%@",filePath);
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"db.sqlite"];
    return dbFilePath;
}


-(BOOL)openDB{
    
    //
    if (!_db) {
        self.db = [FMDatabase databaseWithPath:[self databaseFilePath]];
    }
    //
    if (![_db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    
    return YES;
}

-(BOOL)createTable{
    if (![self openDB]) {
        return NO;
    }
    
    [_db setKey:@"wuyoujian"];
    [_db setShouldCacheStatements:YES];

    if(![_db tableExists:@"people"]){
      return [_db executeUpdate:@"create table people(people_id INTEGER PRIMARY KEY, name TEXT, age INTEGER)"];
    }
    
    return NO;
}

-(void)insertPeople:(People *)aPeople{
    BOOL bSuc = [self openDB];
    if (!bSuc) {
        return;
    }

    [_db setKey:@"wuyoujian"];
    
    [_db setShouldCacheStatements:YES];
    
    FMResultSet *rs = [_db executeQuery:@"select * from people where people_id = ?",[NSString stringWithFormat:@"%ld",(long)aPeople.peopleID]];
    if([rs next])
    {
        [_db executeUpdate:@"update people set name = ?, age = ? where people_id = 1",aPeople.name,[NSString stringWithFormat:@"%ld",(long)aPeople.age]];
    }

    else{
        [_db executeUpdate:@"insert into people (name, age) values (?,?)",aPeople.name,[NSString stringWithFormat:@"%ld",(long)aPeople.age]];
    }
    
    
}

-(NSArray *)getAllPeople{
    
    BOOL bSuc = [self openDB];
    if (!bSuc) {
        return nil;
    }
    
    [_db setKey:@"wuyoujian"];
    [_db setShouldCacheStatements:YES];
    NSMutableArray *peopleArray = [[NSMutableArray alloc] initWithArray:0];

    FMResultSet *rs = [_db executeQuery:@"select * from people"];
    while ([rs next]) {
        People *aPeople = [[People alloc] init];
        
        aPeople.peopleID = [rs intForColumn:@"people_id"];
        aPeople.name = [rs stringForColumn:@"name"];
        aPeople.age = [rs intForColumn:@"age"];
        [peopleArray addObject:aPeople];
    }
    return peopleArray;
}

-(NSArray *)getAllPeople_test{
    
    BOOL bSuc = [self openDB];
    if (!bSuc) {
        return nil;
    }
    
    [_db setShouldCacheStatements:YES];
    NSMutableArray *peopleArray = [[NSMutableArray alloc] initWithArray:0];
    FMResultSet *rs = [_db executeQuery:@"select * from people"];
    while ([rs next]) {
        People *aPeople = [[People alloc] init];
        
        aPeople.peopleID = [rs intForColumn:@"people_id"];
        aPeople.name = [rs stringForColumn:@"name"];
        aPeople.age = [rs intForColumn:@"age"];
        [peopleArray addObject:aPeople];
    }
    return peopleArray;
}


-(void)closeDB{
    [_db close];
}

@end
