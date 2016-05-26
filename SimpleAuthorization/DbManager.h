//
//  DbManager.h
//  SimpleAuthorization
//
//  Created by Ryan Huynh on 5/21/16.
//  Copyright © 2016 Infoway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DbManager : NSObject{
    NSString *databasePath;
    NSInteger user_id;
    
}
+(DbManager*) getSharedInstance;
-(BOOL)createDB;
-(BOOL)registerUser: (NSString *)username
                   : (NSString *)password;
//-(BOOL)findUser: (NSString*) username;
-(BOOL)login: (NSString *)username
            : (NSString *)password;
-(BOOL)addDrink: (NSString *)name
               : (NSString *)price;
-(NSMutableArray *)getDrinkCollection;

-(void)deleteDrink: (NSString *)name;

@end
