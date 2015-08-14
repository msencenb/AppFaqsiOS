//
//  APFQuestionTests.m
//  AppFaqs
//
//  Created by Matt Sencenbaugh on 8/5/15.
//  Copyright (c) 2015 Matt Sencenbaugh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <AppFaqs/APFQuestion.h>

@interface APFQuestionTests : XCTestCase

@end

@implementation APFQuestionTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitializeQuestion
{
    NSString *question = @"What is the answer to everything?";
    NSString *answer = @"42";
    NSDictionary *questionPayload = @{@"title": question, @"answer": answer };
    APFQuestion *q = [[APFQuestion alloc] initWithDictionary:questionPayload];
    XCTAssertTrue([q.question isEqualToString:question]);
    XCTAssertEqual(q.answer, answer);
}

- (void)testRequestsQuestionsFromARemoteURL
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing retrieve questions"];

    [APFQuestion getAllQuestionsWithApiKey:@"xEpc9SGp18mFr2Yz2yunrY39" withSuccessCallback:^(NSArray *questions, BOOL promotionOn){
        XCTAssertNotNil(questions);
        [expectation fulfill];
    } withErrorCallback:^(NSError *error, NSNumber *statusCode, NSString *readableError){
        XCTFail(@"Questions failed to retrieve from server");
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
    }];
}

@end
