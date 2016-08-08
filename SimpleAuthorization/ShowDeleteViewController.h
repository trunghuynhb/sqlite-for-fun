//
//  ShowDeleteViewController.h
//

#import <UIKit/UIKit.h>
#import "DbManager.h"
@interface ShowDeleteViewController : UIViewController<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
