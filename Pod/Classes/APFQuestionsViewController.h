//
//  APFQuestionsViewController.h
//  Pods
//
//  Created by Matt Sencenbaugh on 8/5/15.
//
//

#import <UIKit/UIKit.h>
#import "APFaqs.h"

@interface APFQuestionsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, copy) NSString *apiKey;
@property(nonatomic, weak) id<APFDelegate> delegate;

@end
