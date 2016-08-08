//
//  DrinkListViewController.h
//

#import <UIKit/UIKit.h>
#import "DbManager.h"
@interface DrinkListViewController : UIViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
