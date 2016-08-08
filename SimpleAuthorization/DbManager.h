//
//  DbManager.h
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DbManager : NSObject{
    NSString *databasePath;
    NSInteger user_id;
    NSMutableArray *deleteDrinkCollection;
    
}
+(DbManager*) getSharedInstance;
-(BOOL)createDB;
-(BOOL)registerUser: (NSString *)username
                   : (NSString *)password;

-(BOOL)login: (NSString *)username
            : (NSString *)password;
-(BOOL)addDrink: (NSString *)name
               : (NSString *)price;
-(NSMutableArray *)getDrinkCollection;

-(void)deleteDrink: (NSString *)name;
-(NSMutableArray *)getDeleteDrinkCollection;
@end
