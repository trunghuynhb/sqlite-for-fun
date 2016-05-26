//
//  CreateNewDrinkViewController.h
//  SimpleAuthorization
//
//  Created by Ryan Huynh on 5/25/16.
//  Copyright © 2016 Infoway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbManager.h"
@interface CreateNewDrinkViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *name;

@property (strong, nonatomic) IBOutlet UITextField *price;


- (IBAction)CreateNewDrink:(id)sender;


@end
