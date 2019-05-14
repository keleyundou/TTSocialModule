// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModule
 * FILENAME:     TTWeiboShared.h
 * AUTHER:       ColaBean
 * CREATE TIME:  2019/5/14
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//

#import "TTShared.h"
#import <Weibo_SDK/WeiboSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTWeiboShared : TTShared<WeiboSDKDelegate>

- (BOOL)sendMessageObject:(TTSocialMessageObject *)messageObject viewController:(UIViewController * _Nullable)vCtrl;

@end

NS_ASSUME_NONNULL_END
