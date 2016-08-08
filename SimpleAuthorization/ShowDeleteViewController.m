//
//  ShowDeleteViewController.m
//

#import "ShowDeleteViewController.h"

@interface ShowDeleteViewController ()

@end

@implementation ShowDeleteViewController

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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return [[[DbManager getSharedInstance] getDeleteDrinkCollection] count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // show the deleteDrink on table view
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deleteDrink"];
    cell.textLabel.text = [[DbManager getSharedInstance] getDeleteDrinkCollection][indexPath.row];
    
    return cell;
}

@end
