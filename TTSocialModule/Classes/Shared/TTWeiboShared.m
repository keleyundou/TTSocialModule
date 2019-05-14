// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModule
 * FILENAME:     TTWeiboShared.m
 * AUTHER:       ColaBean
 * CREATE TIME:  2019/5/14
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//

#import "TTWeiboShared.h"
#import "TTSocialUtil.h"
#import "TTSocialMessageObject.h"
#import "TTSocialResponse.h"

@implementation TTWeiboShared

- (BOOL)sendMessageObject:(TTSocialMessageObject *)messageObject viewController:(UIViewController *)vCtrl {
    WBAuthorizeRequest *authReq = [WBAuthorizeRequest request];
    authReq.redirectURI = self.redirectURL;
    authReq.scope = @"all";
    authReq.shouldShowWebViewForAuthIfCannotSSO = YES;
    ParseMessageObject(messageObject);
    WBMessageObject *message = [WBMessageObject message];
    switch (ParseMessageObject(messageObject)) {
        case TTSHARE_TYPE_TEXT:
            message.text = CutoutStringLength(messageObject.text, 2000);
            break;
        case TTSHARE_TYPE_IMAGE:
        {
            TTSharedImageObject *sharedObject = (TTSharedImageObject *)messageObject.sharedObject;
            WBImageObject *imageObject = [WBImageObject object];
            
            UIImage *img = nil;
            if ([sharedObject.shareImage isKindOfClass:NSString.class]) {
                NSString *shareImgStr = sharedObject.shareImage;
                if ([shareImgStr hasPrefix:@"http://"] || [shareImgStr hasPrefix:@"https://"]) {
                    NSLog(@"暂不支持分享到微博平台网络图片");
                    return NO;
                } else {
                    img = [UIImage imageNamed:shareImgStr];
                }
            } else if ([sharedObject.shareImage isKindOfClass:UIImage.class]) {
                img = sharedObject.shareImage;
            } else if ([sharedObject.shareImage isKindOfClass:NSData.class]) {
                img = [UIImage imageWithData:sharedObject.shareImage];
            }
            
            imageObject.imageData = ScaledImage(img, 10*1000*1000).convertToData;
            message.imageObject = imageObject;
            message.text = CutoutStringLength(sharedObject.desc, 2000);
        }
            break;
        case TTSHARE_TYPE_WEB_PAGE:
        {
            TTSharedWebPageObject *sharedObject = (TTSharedWebPageObject *)messageObject.sharedObject;
            WBWebpageObject *webpageObject = [WBWebpageObject object];
            webpageObject.webpageUrl = sharedObject.webpageUrl;
            if (sharedObject.wbObjectID == nil || sharedObject.wbObjectID.length == 0) {
                NSLog(@"⚠️⚠️⚠️ShareError: Weibo 分享webpage 至 objectID不能为空!⚠️⚠️⚠️");
            }
            webpageObject.objectID = CutoutStringLength(sharedObject.wbObjectID, 255);
            /**
             多媒体内容标题
             @warning 不能为空且长度小于1k
             */
            NSString * title = [NSString stringWithFormat:@"%@%@", messageObject.text, sharedObject.webpageUrl];
            webpageObject.title = CutoutStringByteSize(title, 1000);
            /**
             多媒体内容描述
             @warning 长度小于1k
             */
            webpageObject.description = CutoutStringByteSize(sharedObject.desc, 1000);
            webpageObject.thumbnailData = ScaledImage(sharedObject.thumbImage, 32*1000).convertToData;
            message.mediaObject = webpageObject;
            message.text = CutoutStringLength(messageObject.text, 2000);
        }
            break;
        default:
            break;
    }
    //    WBSendMessageToWeiboRequest * request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authReq access_token:[RTWeiboRespManager defaultManager].resp.accessToken];
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    //key:ShareMessageFrom value: 分享的界面。目前先写死
    request.userInfo = @{@"ShareMessageFrom": vCtrl?NSStringFromClass(vCtrl.class):@"ShareController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    return [WeiboSDK sendRequest:request];

}

#pragma mark - WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    NSLog(@"🍻🍻🍻微博分享完成🍻🍻🍻");
    NSLog(@"BaseResp: %@", NSStringFromClass(response.class));
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        TTSocialSharedResponse *sharedResp = [TTSocialSharedResponse new];
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        sharedResp.accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        sharedResp.uid = [sendMessageToWeiboResponse.authResponse userID];
        sharedResp.platformType = self.platform;
        sharedResp.origResp = response;
        NSError *error = nil;
        NSString *errStr = nil;
        
        //            WeiboSDKResponseStatusCodeSuccess               = 0,//成功
        //            WeiboSDKResponseStatusCodeUserCancel            = -1,//用户取消发送
        //            WeiboSDKResponseStatusCodeSentFail              = -2,//发送失败
        //            WeiboSDKResponseStatusCodeAuthDeny              = -3,//授权失败
        //            WeiboSDKResponseStatusCodeUserCancelInstall     = -4,//用户取消安装微博客户端
        //            WeiboSDKResponseStatusCodePayFail               = -5,//支付失败
        //            WeiboSDKResponseStatusCodeShareInSDKFailed      = -8,//分享失败 详情见response UserInfo
        //            WeiboSDKResponseStatusCodeUnsupport             = -99,//不支持的请求
        //            WeiboSDKResponseStatusCodeUnknown               = -100,
        
        NSDictionary *errMap = @{
                                 @"0" : TT_SOCIAL_SHARE_RESULT_STATUS_SEND_SUCCESS,
                                 @"-1":TT_SOCIAL_SHARE_RESULT_STATUS_SEND_CANCEL,
                                 @"-2":@"发送失败！",
                                 @"-3":@"授权失败！",
                                 @"-4":@"用户取消安装微博客户端",
                                 @"-8":TT_SOCIAL_SHARE_RESULT_STATUS_SEND_FAILURE,
                                 @"-100":@"未知错误！",
                                 };
        
        errStr = [errMap objectForKey:@(response.statusCode).stringValue];
        if (response.statusCode != WeiboSDKResponseStatusCodeSuccess) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:errStr, NSLocalizedDescriptionKey,nil];
            error = [NSError errorWithDomain:@"TTSocialErrorSharedResp" code:1001 userInfo:userInfo];
        }
        if (self.sharedCompletionHandler) {
            self.sharedCompletionHandler(sharedResp, error);
        }
    }

}

@end
