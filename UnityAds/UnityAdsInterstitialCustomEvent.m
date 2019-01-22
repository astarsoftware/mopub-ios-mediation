//
//  UnityAdsInterstitialCustomEvent.m
//  MoPubSDK
//
//  Copyright (c) 2016 MoPub. All rights reserved.
//

#import "UnityAdsInterstitialCustomEvent.h"
#import "UnityAdsInstanceMediationSettings.h"
#import "MPUnityRouter.h"
#if __has_include("MoPub.h")
    #import "MPLogging.h"
#endif

static NSString *const kMPUnityInterstitialVideoGameId = @"gameId";
static NSString *const kUnityAdsOptionPlacementIdKey = @"placementId";
static NSString *const kUnityAdsOptionZoneIdKey = @"zoneId";

@interface UnityAdsInterstitialCustomEvent () <MPUnityRouterDelegate>

@property BOOL loadRequested;
@property (nonatomic, copy) NSString *placementId;

@end

@implementation UnityAdsInterstitialCustomEvent

- (void)dealloc
{
    [[MPUnityRouter sharedRouter] clearDelegate:self];
}

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info {
    self.loadRequested = YES;
    NSString *gameId = [info objectForKey:kMPUnityInterstitialVideoGameId];
    self.placementId = [info objectForKey:kUnityAdsOptionPlacementIdKey];
    if (self.placementId == nil) {
        self.placementId = [info objectForKey:kUnityAdsOptionZoneIdKey];
    }
    if (gameId == nil || self.placementId == nil) {
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:[NSError errorWithDomain:@"" code:-1200 userInfo:@{NSLocalizedDescriptionKey: @"Custom event class data did not contain gameId/placementId.", NSLocalizedRecoverySuggestionErrorKey: @"Update your MoPub custom event class data to contain a valid Unity Ads gameId/placementId."}]];
        return;
    }
    [[MPUnityRouter sharedRouter] requestVideoAdWithGameId:gameId placementId:self.placementId delegate:self];
}

- (BOOL)hasAdAvailable
{
    return [[MPUnityRouter sharedRouter] isAdAvailableForPlacementId:self.placementId];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)viewController
{
    if ([self hasAdAvailable]) {
        [[MPUnityRouter sharedRouter] presentVideoAdFromViewController:viewController customerId:nil placementId:self.placementId settings:nil delegate:self];
    } else {
        MPLogInfo(@"Failed to show Unity Interstitial: Unity now claims that there is no available video ad.");
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:nil];
    }
}

- (void)handleCustomEventInvalidated
{
    [[MPUnityRouter sharedRouter] clearDelegate:self];
}

- (void)handleAdPlayedForCustomEventNetwork
{
    // If we no longer have an ad available, report back up to the application that this ad expired.
    // We receive this message only when this ad has reported an ad has loaded and another ad unit
    // has played a video for the same ad network.
    if (![self hasAdAvailable]) {
        [self.delegate interstitialCustomEventDidExpire:self];
    }}

#pragma mark - MPUnityRouterDelegate

- (void)unityAdsReady:(NSString *)placementId
{
    if (self.loadRequested) {
        [self.delegate interstitialCustomEvent:self didLoadAd:placementId];
        self.loadRequested = NO;
    }
}

- (void)unityAdsDidError:(UnityAdsError)error withMessage:(NSString *)message
{
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:nil];
}

- (void) unityAdsDidStart:(NSString *)placementId
{
    [self.delegate interstitialCustomEventWillAppear:self];
    [self.delegate interstitialCustomEventDidAppear:self];
}

- (void) unityAdsDidFinish:(NSString *)placementId withFinishState:(UnityAdsFinishState)state
{
    [self.delegate interstitialCustomEventWillDisappear:self];
    [self.delegate interstitialCustomEventDidDisappear:self];
}

- (void) unityAdsDidClick:(NSString *)placementId
{
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
}

- (void)unityAdsDidFailWithError:(NSError *)error
{
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

@end
