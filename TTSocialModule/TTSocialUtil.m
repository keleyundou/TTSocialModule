// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModule
 * FILENAME:     TTSocialUtil.m
 * AUTHER:       ColaBean
 * CREATE TIME:  2019/5/14
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//

#import "TTSocialUtil.h"

#import <WechatOpenSDK/WXApi.h>

#import "TTSocialMessageObject.h"

inline NSString *HandleWeChatRespErrorInfoCode(int errCode) {
    NSString *errStr = @"";
    switch (errCode) {
        case WXSuccess:
            errStr = TT_SOCIAL_SHARE_RESULT_STATUS_SEND_SUCCESS;
            break;
        case WXErrCodeCommon:
            errStr = @"普通错误类型";
            break;
        case WXErrCodeUserCancel:
            errStr = TT_SOCIAL_SHARE_RESULT_STATUS_SEND_CANCEL;
            break;
        case WXErrCodeSentFail:
            errStr = TT_SOCIAL_SHARE_RESULT_STATUS_SEND_FAILURE;
            break;
        case WXErrCodeAuthDeny:
            errStr = @"授权失败";
            break;
        case WXErrCodeUnsupport:
            errStr = @"微信不支持";
            break;
        default:
            break;
    }
    return errStr;
}

inline TTSHARE_TYPE ParseMessageObject(TTSocialMessageObject *messageObject) {
    if ([messageObject.sharedObject isKindOfClass:TTSharedImageObject.class]) {
        return TTSHARE_TYPE_IMAGE;//image
    } else if ([messageObject.sharedObject isKindOfClass:TTSharedWebPageObject.class]) {
        return TTSHARE_TYPE_WEB_PAGE;//webpage
    } else if ([messageObject.sharedObject isKindOfClass:TTSharedMiniProgramObject.class]) {
        return TTSHARE_TYPE_MINI_PROGRAM;//小程序
    } else if (messageObject.sharedObject == nil) {
        return TTSHARE_TYPE_TEXT;//纯文本
    }
    return TTSHARE_TYPE_UNKNOWN;
}

inline UIImage *ScaledImage(UIImage *origImage, NSInteger maxBytes) {
    NSInteger oriImageBytes = origImage.convertToData.length;
    UIImage* scaledImage = origImage;
    while (oriImageBytes > maxBytes) {
        CGFloat scaleFactor = maxBytes * 1.0f / oriImageBytes * 1.0f;
        scaledImage = [scaledImage scaledToSize:scaleFactor];
        oriImageBytes = scaledImage.convertToData.length;
    }
    return scaledImage;
}

inline NSString *CutoutStringLength(NSString *aString, NSUInteger maxLength) {
    if ([aString length] > maxLength) {
        aString = [aString substringToIndex:maxLength];
    }
    return aString;
}

inline NSString *CutoutStringByteSize(NSString *aString, NSUInteger maxByteSize) {
    NSString *text = aString;
    if ([text dataUsingEncoding:NSUTF8StringEncoding].length <= maxByteSize) {
        return text;
    }
    NSString *lastStr = nil;//url后面的str 包含url
    NSError *error = nil;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
    if (!error) {
        NSArray *matches = [detector matchesInString:text options:NSMatchingReportProgress range:NSMakeRange(0, text.length)];
        if (matches.count) {
            NSTextCheckingResult *result = matches.firstObject;
            NSString *urlPreStr = [text substringToIndex:result.range.location];
            NSString *urlLastStr = [text substringFromIndex:result.range.location];
            lastStr = urlLastStr;
            NSData *dd = [urlLastStr dataUsingEncoding:NSUTF8StringEncoding];
            if (dd.length < maxByteSize) {
                maxByteSize = maxByteSize - dd.length;
                text = urlPreStr;
            }
        }
    }
    
    NSRange unitCharRange;
    NSUInteger total = 0;
    /*
     ... 占3byte
     */
    maxByteSize -= 3;
    for (NSUInteger i = 0; i < text.length; i += unitCharRange.length) {
        if (total >= maxByteSize) {
            break;
        }
        unitCharRange = [text rangeOfComposedCharacterSequenceAtIndex:i];
        NSString *s = [text substringWithRange:unitCharRange];
        NSData *data = [s dataUsingEncoding:NSUTF8StringEncoding];
        total += data.length;
    }
    
    NSString *result = [text substringToIndex:unitCharRange.location];
    if (result && result.length) {
        result = [result stringByAppendingString:@"..."];
    }
    if (lastStr) {
        result = [result stringByAppendingString:lastStr];
    }
    return result;
}

@implementation UIImage (TTConvertHandler)

- (NSData *)convertToData {
    return UIImageJPEGRepresentation(self, 1.0);
}

- (UIImage *)scaledToSize:(CGFloat)threshold {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width*threshold, self.size.height*threshold), NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width*threshold, self.size.height*threshold)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
