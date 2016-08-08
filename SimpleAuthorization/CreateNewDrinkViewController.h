//
//  CreateNewDrinkViewController.h
//

#import <UIKit/UIKit.h>
#import "DbManager.h"
@interface CreateNewDrinkViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *name;

@property (strong, nonatomic) IBOutlet UITextField *price;


- (IBAction)CreateNewDrink:(id)sender;


@end
