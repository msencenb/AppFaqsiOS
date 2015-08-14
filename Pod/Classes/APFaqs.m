//
//  APFaqs.m
//  Pods
//
//  Created by Matt Sencenbaugh on 8/7/15.
//
//

#import "APFaqs.h"
#import "APFQuestionsViewController.h"

@implementation APFaqs
+ (UIViewController *)faqWithApiKey:(NSString *)apiKey withDelegate:(id)delegate
{
    APFQuestionsViewController *vc = [[APFQuestionsViewController alloc] init];
    vc.apiKey = apiKey;
    vc.delegate = delegate;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    return nav;
}
@end
