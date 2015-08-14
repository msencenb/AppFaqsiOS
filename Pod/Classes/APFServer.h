//
//  APFServer.h
//  Pods
//
//  Created by Matt Sencenbaugh on 8/7/15.
//
//

#import <Foundation/Foundation.h>

typedef void (^APFSuccessHandler)(NSDictionary *responseJSON);
typedef void (^APFErrorHandler)(NSError *error, NSNumber *statusCode, NSString *readableError);

@interface APFServer : NSObject
@property(nonatomic,assign) BOOL testMode;

+ (instancetype)sharedServer;
- (instancetype)init;
- (void)get:(NSURL *)url withSuccessHandler:(APFSuccessHandler)successHandler withErrorhandler:(APFErrorHandler)errorHandler;

@end
