//
//  APFQuestionDetailViewController.m
//  Pods
//
//  Created by Matt Sencenbaugh on 8/5/15.
//
//

#import "APFQuestionDetailViewController.h"
#import "APFQuestion.h"

@interface APFQuestionDetailViewController ()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *bodyLabel;
@end

@implementation APFQuestionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Question";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scrollView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    titleLabel.text = self.question.question;
    titleLabel.accessibilityTraits = UIAccessibilityTraitHeader;
    titleLabel.accessibilityValue = self.question.question;
    self.titleLabel = titleLabel;
    [scrollView addSubview:titleLabel];
    
    UILabel *bodyLabel = [[UILabel alloc] init];
    bodyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    bodyLabel.numberOfLines = 0;
    bodyLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    bodyLabel.text = self.question.answer;
    bodyLabel.accessibilityTraits = UIAccessibilityTraitStaticText;
    bodyLabel.accessibilityValue = self.question.answer;
    self.bodyLabel = bodyLabel;
    [scrollView addSubview:bodyLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(bodyLabel, titleLabel, scrollView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:nil views:views]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[titleLabel]-8-[bodyLabel]-8-|" options:0 metrics:nil views:views]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[titleLabel]-8-|" options:0 metrics:nil views:views]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[bodyLabel]-8-|" options:0 metrics:nil views:views]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.titleLabel.preferredMaxLayoutWidth = self.view.frame.size.width - 16;
    self.bodyLabel.preferredMaxLayoutWidth = self.view.frame.size.width - 16;
    [self.view layoutIfNeeded];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         self.bodyLabel.preferredMaxLayoutWidth = size.width - 16;
         self.titleLabel.preferredMaxLayoutWidth = size.width - 16;
     } completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         [self.view setNeedsLayout];
         [self.view layoutIfNeeded];
     }];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

@end
