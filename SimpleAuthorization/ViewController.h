//
//  ViewController.h
//

#import <UIKit/UIKit.h>
#import "DbManager.h"
@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *username;

@property (strong, nonatomic) IBOutlet UITextField *password;


- (IBAction)reg:(id)sender;

- (IBAction)login:(id)sender;
@end

