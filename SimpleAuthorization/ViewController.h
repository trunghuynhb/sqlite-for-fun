//
//  ViewController.h
//  SimpleAuthorization
//
//  Created by Ryan Huynh on 5/21/16.
//  Copyright © 2016 Infoway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbManager.h"
@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *username;

@property (strong, nonatomic) IBOutlet UITextField *password;


- (IBAction)reg:(id)sender;

- (IBAction)login:(id)sender;
@end

