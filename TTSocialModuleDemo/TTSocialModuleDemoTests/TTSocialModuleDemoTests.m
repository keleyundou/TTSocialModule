// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModuleDemo
 * FILENAME:     TTSocialModuleDemoTests.m
 * AUTHER:       ColaBean
 * CREATE TIME:  2019/5/14
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//

#import <XCTest/XCTest.h>

#import "TTSocialManager.h"
#import "TTSocialMessageObject.h"

@interface TTSocialModuleDemoTests : XCTestCase

@end

@implementation TTSocialModuleDemoTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testAppIsInstalled {
    BOOL isAppInstalled = [[TTSocialManager defaultManager] isInstalledForPlatform:TTSocialPlatformTypeWeChatSession];
    NSLog(@"微信%@安装", isAppInstalled?@"已":@"未");
    
    isAppInstalled = [[TTSocialManager defaultManager] isInstalledForPlatform:TTSocialPlatformTypeWeibo];
    NSLog(@"微博%@安装", isAppInstalled?@"已":@"未");
    
    isAppInstalled = [[TTSocialManager defaultManager] isInstalledForPlatform:TTSocialPlatformTypeQZone];
    NSLog(@"QZone%@安装", isAppInstalled?@"已":@"未");
    
}

- (void)testSharedToWeChatSession {
    TTSocialMessageObject *messageObject = [TTSocialMessageObject new];
    messageObject.text = @"分享文本";
    
    [[TTSocialManager defaultManager] sharedToPlatform:TTSocialPlatformTypeWeChatSession messageObject:messageObject currentViewController:nil completionHandler:^(id  _Nullable data, NSError * _Nullable error) {
        NSLog(@"%@::分享后的回调！", NSStringFromClass(self.class));
    }];
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
