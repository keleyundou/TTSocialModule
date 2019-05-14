// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModule
 * FILENAME:     TTShared.h
 * AUTHER:       ColaBean
 * CREATE TIME:  2019/5/14
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//

#import <Foundation/Foundation.h>
#import "TTBehavior.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTShared : NSObject<TTShared>

- (BOOL)sendMessageObject:(TTSocialMessageObject *)messageObject viewController:(UIViewController * _Nullable)vCtrl;

@end

NS_ASSUME_NONNULL_END
