//
//  DrinkListViewController.m
//

#import "DrinkListViewController.h"

@interface DrinkListViewController ()

@end

@implementation DrinkListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // set the navigation icon to be a plus with addNewDrink selector
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewDrink:)];
    // set the navigation icon to be a done with showDeleteDrinks selector
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(showDeleteDrinks:)];
}

-(void)addNewDrink:(UIBarButtonItem *)sender{
    
    [self performSegueWithIdentifier:@"addDrink" sender:nil];
    
}

-(void)showDeleteDrinks:(UIBarButtonItem *)sender{
    
    [self performSegueWithIdentifier:@"showDeleteItems" sender:nil];

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
    // the count of items in drinkcollection
    return [[[DbManager getSharedInstance] getDrinkCollection] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // set the cell to display the name of each item
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [[DbManager getSharedInstance] getDrinkCollection][indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // swipe-able cell, delete a item out of database
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [[DbManager getSharedInstance] deleteDrink:[[[DbManager getSharedInstance] getDrinkCollection] objectAtIndex:indexPath.row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        NSLog(@"Unhandled editing style! %ld", (long)editingStyle);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // reload changes
    [self.tableView reloadData];
}
@end
