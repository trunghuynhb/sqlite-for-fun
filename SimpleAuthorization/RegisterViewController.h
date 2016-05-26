//
//  RegisterViewController.h
//  SimpleAuthorization
//
//  Created by Ryan Huynh on 5/22/16.
//  Copyright © 2016 Infoway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbManager.h"

@interface RegisterViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *password;

@property (strong, nonatomic) IBOutlet UITextField *username;
- (IBAction)submit:(id)sender;
@end
