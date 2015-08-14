//
//  APFaqs.h
//  Pods
//
//  Created by Matt Sencenbaugh on 8/7/15.
//
//

#import <Foundation/Foundation.h>

@protocol APFDelegate <NSObject>
-(void)closeButtonWasPressed;
@end

@interface APFaqs : NSObject

+ (UIViewController *)faqWithApiKey:(NSString *)apiKey withDelegate:(id)delegate;

@end
