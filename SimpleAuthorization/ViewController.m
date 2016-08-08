//
//  ViewController.m
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
//BOOL check;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //NSLog(@"diload");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reg:(id)sender {
    [self performSegueWithIdentifier:@"register" sender: nil];
    
}

- (IBAction)login:(id)sender {

    if (_username.text.length>0 && _password.text.length>0) {
        // check for authentication
        BOOL check;
        check=[[DbManager getSharedInstance]login:_username.text :_password.text];
        
        if (check==YES) {
            NSLog(@"log success");
            [self performSegueWithIdentifier:@"sucess" sender: nil];
        }
        else NSLog(@"login fail");
    }
    else NSLog(@"Miss field");
}
@end
