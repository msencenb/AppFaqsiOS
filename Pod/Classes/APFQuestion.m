//
//  APFQuestion.m
//  Pods
//
//  Created by Matt Sencenbaugh on 8/5/15.
//
//

#import "APFQuestion.h"
#import "APFServer.h"

@implementation APFQuestion
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.question = [dictionary objectForKey:@"title"];
        self.answer = [dictionary objectForKey:@"answer"];
    }
    return self;
}

+ (void)getAllQuestionsWithApiKey:(NSString *)apiKey withSuccessCallback:(APFQuestionSuccessHandler)successCallback withErrorCallback:(APFQuestionErrorHandler)errorCallback
{
    APFServer *server = [APFServer sharedServer];
    NSString *urlString = [NSString stringWithFormat:@"https://appfaqs.co/api/apps/%@/questions.json", apiKey];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [server get:url withSuccessHandler:^(NSDictionary *responseJSON){
        NSMutableArray *questions = [NSMutableArray array];
        
        BOOL promo = [[responseJSON objectForKey:@"promo"] boolValue];
        NSArray *questionsJSON = [responseJSON objectForKey:@"questions"];
        for (NSDictionary *questionJSON in questionsJSON) {
            APFQuestion *question = [[APFQuestion alloc] initWithDictionary:questionJSON];
            [questions addObject:question];
        }
        successCallback(questions, promo);
    } withErrorhandler:^(NSError *error, NSNumber *statusCode, NSString *readableError){
        errorCallback(error, statusCode, readableError);
    }];
}
@end
