//
//  APFViewController.m
//  AppFaqs
//
//  Created by Matt Sencenbaugh on 08/03/2015.
//  Copyright (c) 2015 Matt Sencenbaugh. All rights reserved.
//

#import "APFViewController.h"

@interface APFViewController ()

@end

@implementation APFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)launchFAQPressed:(id)sender {
    UIViewController *viewController = [APFaqs faqWithApiKey:@"xEpc9SGp18mFr2Yz2yunrY39" withDelegate:self];
    [self presentViewController:viewController animated:YES completion:^{}];
}

#pragma mark - APFDelegate
-(void)closeButtonWasPressed
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
