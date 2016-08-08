//
//  CreateNewDrinkViewController.m
//

#import "CreateNewDrinkViewController.h"

@interface CreateNewDrinkViewController ()

@end

@implementation CreateNewDrinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)CreateNewDrink:(id)sender {
    if (_name.text.length>0 && _price.text.length>0) {
        
        [[DbManager getSharedInstance]addDrink:_name.text :_price.text];
        
    }
    else NSLog(@"Enter the field");
}
@end
