//
//  APFQuestion.h
//  Pods
//
//  Created by Matt Sencenbaugh on 8/5/15.
//
//

#import <Foundation/Foundation.h>

// Block callbacks for the API methods
typedef void (^APFQuestionSuccessHandler)(NSArray *questions, BOOL promotionOn);
typedef void (^APFQuestionErrorHandler)(NSError *error, NSNumber *statusCode, NSString *readableError);

@interface APFQuestion : NSObject

@property(nonatomic, copy) NSString *question;
@property(nonatomic, copy) NSString *answer;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (void)getAllQuestionsWithApiKey:(NSString *)apiKey withSuccessCallback:(APFQuestionSuccessHandler)successCallback withErrorCallback:(APFQuestionErrorHandler)errorCallback;
@end
