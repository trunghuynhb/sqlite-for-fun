//
//  DrinkListViewController.h
//  SimpleAuthorization
//
//  Created by Ryan Huynh on 5/25/16.
//  Copyright © 2016 Infoway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbManager.h"
@interface DrinkListViewController : UIViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
