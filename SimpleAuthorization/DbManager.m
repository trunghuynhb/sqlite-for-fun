//
//  DbManager.m
//  SimpleAuthorization
//
//  Created by Ryan Huynh on 5/21/16.
//  Copyright © 2016 Infoway. All rights reserved.
//

#import "DbManager.h"
static DbManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DbManager

+(DbManager*)getSharedInstance{
    
    if(!sharedInstance){
        //init a DbManager obj
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    
    return sharedInstance;
}

-(bool)createDB{
    BOOL isSuccess = YES;
    NSString *docsDir;
    NSArray *dirPaths;
    NSFileManager *fileMgr= [NSFileManager defaultManager];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    databasePath = ([[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"user.db"]]);
    NSLog(@"%@", databasePath);
    
    if (![fileMgr fileExistsAtPath:databasePath]) {
        
        const char *dbpath= [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database)== SQLITE_OK) {
            
            char *err;
            const char *query= "create table if not exists user (id integer primary key autoincrement, username text unique, password text)";
            const char *drinksQuery= "create table if not exists drinks (id integer primary key autoincrement, user_id integer, name text, price text)";
            if (sqlite3_exec(database, query, NULL, NULL,&err) != SQLITE_OK){
                isSuccess=NO;
            }
            
            if (sqlite3_exec(database, drinksQuery, NULL, NULL,&err) != SQLITE_OK){
                isSuccess=NO;
            }
            
            sqlite3_close(database);
            NSLog(@"success crate db");
            return isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"failed to open/create database");
        }
    }
    
    return isSuccess;
}

-(BOOL)registerUser:(NSString *)username :(NSString *)password{
    char *err;
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        
            NSString *insertSQL = [NSString stringWithFormat:@"insert into user (username, password) values (\"%@\",\"%@\")", username, password];
            const char *insert_query = [insertSQL UTF8String];
            if(sqlite3_exec(database, insert_query, NULL, NULL, &err)==SQLITE_OK){
            
                NSLog(@"create success");
                sqlite3_reset(statement);
                return YES;
            }
            else {
                NSLog(@"create failure1");
                sqlite3_reset(statement);
                return NO;
            }
    
    }
    
    return NO;

}


-(BOOL)login:(NSString *)username :(NSString *)password{
 
    BOOL isFound = NO;
    const char *dbpath = [databasePath UTF8String];
    NSLog(@"%@", databasePath);
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"select username from user where username=\"%@\" and password=\"%@\"", username, password];
        const char *query = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, query, -1, &statement, NULL) == SQLITE_OK){
            if (sqlite3_step(statement) == SQLITE_ROW) {
                user_id=sqlite3_column_int(statement, 0);
                sqlite3_reset(statement);
                isFound=YES;
                
                return isFound;
                
            }
            else {
                sqlite3_reset(statement);
                isFound = NO;
                return isFound;
            }
            
        }
    }
    NSLog(@"fail to open");
    return NO;
}

-(BOOL)addDrink:(NSString *)name :(NSString *)price{
    char *err;
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        
        
        NSString *insertSQL = [NSString stringWithFormat:@"insert into drinks (user_id, name, price) values (\"%ld\",\"%@\",\"%@\")", (long)user_id, name, price];
        const char *insert_query = [insertSQL UTF8String];
        if(sqlite3_exec(database, insert_query, NULL, NULL, &err)==SQLITE_OK){
            
            NSLog(@"create success");
            sqlite3_reset(statement);
            return YES;
        }
        else {
            NSLog(@"create failure1");
            sqlite3_reset(statement);
            return NO;
        }
    }
    return NO;
}

-(NSMutableArray *)getDrinkCollection{
 
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK){
        
        NSString *querySQL = [NSString stringWithFormat:@"select * from drinks where user_id = \"%ld\"", user_id];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *drinkCollection = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW){
                
                char *nameField = (char *) sqlite3_column_text(statement, 2);
                NSString *name = [[NSString alloc]initWithUTF8String:nameField];
                [drinkCollection addObject:name];
                NSLog(@"%@", name);
                
            }
        
            sqlite3_reset(statement);
            return drinkCollection;
        }
        
    }
    return nil;
}


-(void)deleteDrink:(NSString *)name {
    char *err;
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        
        
        NSString *deleteSQL = [NSString stringWithFormat:@"delete from drinks where name = \"%@\" and user_id = \"%ld\"", name, (long)user_id];
        const char *delete_query = [deleteSQL UTF8String];
        if(sqlite3_exec(database, delete_query, NULL, NULL, &err)==SQLITE_OK){
            
            NSLog(@"delete success");
            sqlite3_reset(statement);
            
        }
        else {
            NSLog(@"delete failure1");
            sqlite3_reset(statement);
            
        }
    }
    

}


@end
