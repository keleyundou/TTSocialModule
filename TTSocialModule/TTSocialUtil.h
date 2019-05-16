// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModule
 * FILENAME:     TTSocialUtil.h
 * AUTHER:       ColaBean
 * CREATE TIME:  2019/5/14
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//

#import <Foundation/Foundation.h>
#import "TTSocialDefine.h"

NS_ASSUME_NONNULL_BEGIN
@class TTSocialMessageObject;

FOUNDATION_EXPORT NSString * _Nullable HandleWeChatRespErrorInfoCode(int errCode);
FOUNDATION_EXPORT TTSHARE_TYPE ParseMessageObject(TTSocialMessageObject *_Nullable messageObject);
FOUNDATION_EXPORT UIImage *ScaledImage(UIImage *origImage, NSInteger maxBytes);
FOUNDATION_EXPORT NSString *CutoutStringLength(NSString *aString, NSUInteger maxLength);
FOUNDATION_EXPORT NSString *CutoutStringByteSize(NSString *aString, NSUInteger maxByteSize);

@interface UIImage (TTConvertHandler)

- (nullable NSData *)convertToData;
- (UIImage *)scaledToSize:(CGFloat)threshold;

@end

NS_ASSUME_NONNULL_END
