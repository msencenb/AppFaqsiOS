//
//  APFServer.m
//  Pods
//
//  Created by Matt Sencenbaugh on 8/7/15.
//
//

#import "APFServer.h"
@interface APFServer()
@end

@implementation APFServer
+ (instancetype)sharedServer
{
    static APFServer *sharedServer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedServer = [[self alloc] init];
    });
    return sharedServer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.testMode = NO;
    }
    return self;
}

- (void)get:(NSURL *)url withSuccessHandler:(APFSuccessHandler)successHandler withErrorhandler:(APFErrorHandler)errorHandler
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        
        // Deal with connection errors
        if (error) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                errorHandler(error, [NSNumber numberWithInt:-1], error.localizedDescription);
                return;
            });
        }
        
        // Handle response errors
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
        if (urlResponse.statusCode != 200) {
            NSString *readableError = @"Sorry, we are having problems loading the FAQ's right now. Please try again later!";
            NSNumber *numberStatuscode = [NSNumber numberWithInteger:urlResponse.statusCode];
            dispatch_sync(dispatch_get_main_queue(), ^{
                errorHandler(nil,numberStatuscode,readableError);
            });
            return;
        }
        
        // Actually parse the json
        NSError *parseError = nil;
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if (parseError) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                errorHandler(parseError, [NSNumber numberWithInt:-1], parseError.localizedDescription);
            });
            return;
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            successHandler(responseJSON);
        });
        
    }];
    [task resume];
}
@end
