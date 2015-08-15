//
//  APFQuestionsViewController.m
//  Pods
//
//  Created by Matt Sencenbaugh on 8/5/15.
//
//

#import "APFQuestionsViewController.h"
#import "APFQuestion.h"
#import "APFQuestionTableViewCell.h"
#import "APFQuestionDetailViewController.h"

@interface APFQuestionsViewController ()
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *questions;
@property(nonatomic, strong) UIView *footerView;
@property(nonatomic, strong) UIActivityIndicatorView *spinner;
@property(nonatomic, strong) UILabel *errorLabel;
@end

@implementation APFQuestionsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FAQs";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closeButtonPressed)];
    self.navigationItem.leftBarButtonItem = doneButton;
    
    [self setupSpinner];
    
    [self setupTableView];
    [self setupErrorLabel];
    
    self.questions = [NSArray array];

    [APFQuestion getAllQuestionsWithApiKey:self.apiKey withSuccessCallback:^(NSArray *questions, BOOL promotionOn){
        [self.spinner stopAnimating];
        self.questions = questions;
        if (promotionOn) {
            [self setupFooterView];
        }
        [self.tableView reloadData];
    } withErrorCallback:^(NSError *error, NSNumber *statusCode, NSString *readableError){
        [self.spinner stopAnimating];
        self.errorLabel.hidden = NO;
        self.errorLabel.text = readableError;
        self.tableView.hidden = YES;
    }];
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    NSDictionary *views = @{@"tableView":self.tableView};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views]];
    
    self.tableView.estimatedRowHeight = 50.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)setupSpinner
{
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem *loadingView = [[UIBarButtonItem alloc] initWithCustomView:self.spinner];
    self.navigationItem.rightBarButtonItem = loadingView;
    [self.spinner startAnimating];
}

- (void)setupErrorLabel
{
    UILabel *errorLabel = [[UILabel alloc] init];
    errorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    errorLabel.textAlignment = NSTextAlignmentCenter;
    errorLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    errorLabel.numberOfLines = 0;
    errorLabel.hidden = YES;
    [self.view addSubview:errorLabel];
    [self.view bringSubviewToFront:errorLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(errorLabel);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[errorLabel]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[errorLabel]-|" options:0 metrics:nil views:views]];
    
    self.errorLabel = errorLabel;
}

- (void)setupFooterView
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];

    UILabel *poweredLabel = [[UILabel alloc] init];
    poweredLabel.translatesAutoresizingMaskIntoConstraints = NO;
    poweredLabel.textAlignment = NSTextAlignmentCenter;
    poweredLabel.text = @"Powered by AppFaqs.co";
    poweredLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    poweredLabel.textColor = poweredLabel.tintColor;
    poweredLabel.userInteractionEnabled = YES;
    [footer addSubview:poweredLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(poweredButtonPressed)];
    [poweredLabel addGestureRecognizer:tap];
    
    NSDictionary *dict = NSDictionaryOfVariableBindings(poweredLabel);
    [footer addConstraint:[NSLayoutConstraint constraintWithItem:poweredLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:footer attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [footer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[poweredLabel]|" options:0 metrics:nil views:dict]];
    self.tableView.tableFooterView = footer;
}

-(void)poweredButtonPressed
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://appfaqs.co"]];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.questions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    APFQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"questionCell"];
    if (!cell) {
        cell = [[APFQuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"questionCell"];
    }
    APFQuestion *question = [self.questions objectAtIndex:indexPath.row];
    cell.questionLabel.text = question.question;
    cell.isAccessibilityElement = YES;
    cell.accessibilityTraits = UIAccessibilityTraitButton;
    cell.accessibilityValue = question.question;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    APFQuestion *question = [self.questions objectAtIndex:indexPath.row];
    APFQuestionDetailViewController *vc = [[APFQuestionDetailViewController alloc] init];
    vc.question = question;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Done button methods
-(void)closeButtonPressed
{
    if ([self.delegate respondsToSelector:@selector(closeButtonWasPressed)]) {
        [self.delegate closeButtonWasPressed];
    }
}
@end
