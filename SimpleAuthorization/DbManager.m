//
//  DbManager.m
//  Create a SQLite database and using the database to authenticate user login and store some user information.
//

#import "DbManager.h"
static DbManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;
static dispatch_once_t onceToken;

@implementation DbManager

+(DbManager*)getSharedInstance{
    // access/create a threadsafe singleton shareinstance
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    });
    
    return sharedInstance;
}

-(bool)createDB{
    BOOL isSuccess = YES;
    NSString *docsDir;
    NSArray *dirPaths;
    NSFileManager *fileMgr= [NSFileManager defaultManager];
    // get the document directory path
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // create the databasePath by adding user.db into the docDir
    databasePath = ([[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"user.db"]]);
    NSLog(@"%@", databasePath);
    // check and create initial tables
    if (![fileMgr fileExistsAtPath:databasePath]) {
        
        const char *dbpath= [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database)== SQLITE_OK) {
            // create user and drink query
            char *err;
            const char *query= "create table if not exists user (id integer primary key autoincrement, username text unique, password text)";
            const char *drinksQuery= "create table if not exists drinks (id integer primary key autoincrement, user_id integer, name text, price text)";
            // execute queries
            if (sqlite3_exec(database, query, NULL, NULL,&err) != SQLITE_OK){
                isSuccess=NO;
            }
            
            if (sqlite3_exec(database, drinksQuery, NULL, NULL,&err) != SQLITE_OK){
                isSuccess=NO;
            }
            // close the connection when done
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
    // register user insert user into table
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            // create insert query
            NSString *insertSQL = [NSString stringWithFormat:@"insert into user (username, password) values (\"%@\",\"%@\")", username, password];
            const char *insert_query = [insertSQL UTF8String];
            // execute the query
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
    deleteDrinkCollection = [[NSMutableArray alloc]init];
    BOOL isFound = NO;
    const char *dbpath = [databasePath UTF8String];
    // check if user is in the database
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
            // do nothing if fail
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
    // add drink into table
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
    // return an array with all the drinks
    if (sqlite3_open(dbpath, &database) == SQLITE_OK){
        
        NSString *querySQL = [NSString stringWithFormat:@"select * from drinks where user_id = \"%ld\"", user_id];
        const char *query_stmt = [querySQL UTF8String];
        
        NSMutableArray *drinkCollection = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW){
                
                char *nameField = (char *) sqlite3_column_text(statement, 2);
                NSString *name = [[NSString alloc]initWithUTF8String:nameField];
                [drinkCollection addObject:name];
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
    [deleteDrinkCollection addObject:name];
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

-(NSMutableArray *)getDeleteDrinkCollection{
    return deleteDrinkCollection;

}







@end
