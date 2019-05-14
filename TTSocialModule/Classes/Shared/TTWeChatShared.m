// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModule
 * FILENAME:     TTWeChatShared.m
 * AUTHER:       ColaBean
 * CREATE TIME:  2019/5/14
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//

#import "TTWeChatShared.h"
#import "TTSocialUtil.h"
#import "TTSocialMessageObject.h"
#import "TTSocialResponse.h"

@implementation TTWeChatShared

- (BOOL)sendMessageObject:(TTSocialMessageObject *)messageObject viewController:(UIViewController *)vCtrl {
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    enum WXScene wxScene = 0;
    if (self.platform == TTSocialPlatformTypeWeChatSession) {
        wxScene = WXSceneSession;
    } else if (self.platform == TTSocialPlatformTypeWeChatTimeLine) {
        wxScene = WXSceneTimeline;
    }
    req.scene = wxScene;
    
    switch (ParseMessageObject(messageObject)) {
        case TTSHARE_TYPE_TEXT:
            req.text = CutoutStringByteSize(messageObject.text, 10*1000);
            req.bText = YES;
            break;
        case TTSHARE_TYPE_IMAGE:
        {
            TTSharedImageObject *sharedObject = messageObject.sharedObject;
            WXMediaMessage *message = [WXMediaMessage message];
            [message setThumbImage:ScaledImage(sharedObject.thumbImage, 32*1000)];
            
            WXImageObject *ext = [WXImageObject object];
            UIImage *img = nil;
            if ([sharedObject.shareImage isKindOfClass:NSString.class]) {
                NSString *shareImgStr = sharedObject.shareImage;
                if ([shareImgStr hasPrefix:@"http://"] || [shareImgStr hasPrefix:@"https://"]) {
                    NSLog(@"暂不支持分享到微信平台网络图片");
                    return NO;
                } else {
                    img = [UIImage imageNamed:shareImgStr];
                }
            } else if ([sharedObject.shareImage isKindOfClass:UIImage.class]) {
                img = sharedObject.shareImage;
            } else if ([sharedObject.shareImage isKindOfClass:NSData.class]) {
                img = [UIImage imageWithData:sharedObject.shareImage];
            }
            ext.imageData = ScaledImage(img, 10*1000*1000).convertToData;
            message.mediaObject = ext;
            message.title = CutoutStringByteSize(sharedObject.title, 512);
            message.description = CutoutStringByteSize(sharedObject.desc, 1000);
            req.bText = NO;
            req.message = message;
        }
            break;
        case TTSHARE_TYPE_WEB_PAGE:
        {
            TTSharedWebPageObject *sharedObject = (TTSharedWebPageObject *)messageObject.sharedObject;
            WXWebpageObject *webpageObject = [WXWebpageObject object];
            webpageObject.webpageUrl = sharedObject.webpageUrl;
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = CutoutStringByteSize(sharedObject.title, 512);
            /** 描述内容
             * @note 长度不能超过1K
             */
            message.description = sharedObject.desc;
            [message setThumbImage:ScaledImage(sharedObject.thumbImage, 32*1000)];
            message.mediaObject = webpageObject;
            
            req.bText = NO;
            req.message = message;
        }
            break;
        case TTSHARE_TYPE_MINI_PROGRAM:
        {
            TTSharedMiniProgramObject *sharedObject = (TTSharedMiniProgramObject *)messageObject.sharedObject;
            WXMiniProgramObject *wxMiniObject = [WXMiniProgramObject object];
            wxMiniObject.webpageUrl = sharedObject.webpageUrl;
            wxMiniObject.userName = sharedObject.userName;
            wxMiniObject.path = sharedObject.path;
            wxMiniObject.hdImageData = ScaledImage([UIImage imageWithData:sharedObject.hdImageData], 128*1000).convertToData;
            wxMiniObject.withShareTicket = sharedObject.withShareTicket;
            wxMiniObject.miniProgramType = [@(sharedObject.miniProgramType) integerValue];
            
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = CutoutStringByteSize(sharedObject.title, 512);
            /** 描述内容
             * @note 长度不能超过1K
             */
            message.description = CutoutStringByteSize(sharedObject.desc, 1000);
            message.mediaObject = wxMiniObject;
            
            req.bText = NO;
            req.message = message;
        }
            break;
        default:
            NSLog(@"未知消息类型");
            break;
    }
    
    return [WXApi sendReq:req];

}

#pragma mark - WXApiDelegate
- (void)onReq:(BaseReq *)req {}

- (void)onResp:(BaseResp *)resp {
    NSLog(@"🍻🍻🍻微信分享完成🍻🍻🍻");
    NSLog(@"BaseResp: %@", NSStringFromClass(resp.class));
    if ([resp isMemberOfClass:SendMessageToWXResp.class]) {
        NSLog(@"error msg: %@", HandleWeChatRespErrorInfoCode(resp.errCode));
        TTSocialSharedResponse *sharedResp = [TTSocialSharedResponse sharedResponseWithMessage:resp.errStr];
        if (resp.type == WXSceneSession) {
            sharedResp.platformType = TTSocialPlatformTypeWeChatSession;
        } else if (resp.type == WXSceneTimeline) {
            sharedResp.platformType = TTSocialPlatformTypeWeChatTimeLine;
        }
        sharedResp.origResp = resp;
        
        NSError *error = nil;
        if (resp.errCode != WXSuccess) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:HandleWeChatRespErrorInfoCode(resp.errCode)};
            error = [NSError errorWithDomain:@"TTSocialErrorSharedResp" code:1001 userInfo:userInfo];
        }
        
        if (self.sharedCompletionHandler) {
            self.sharedCompletionHandler(sharedResp, error);
        }
    }
}

@end
