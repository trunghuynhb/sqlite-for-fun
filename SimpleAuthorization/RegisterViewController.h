//
//  RegisterViewController.h
//

#import <UIKit/UIKit.h>
#import "DbManager.h"

@interface RegisterViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *password;

@property (strong, nonatomic) IBOutlet UITextField *username;
- (IBAction)submit:(id)sender;
@end
