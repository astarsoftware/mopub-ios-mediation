## Changelog
* 1.0.0.2
    * Adjust minimium MoPub SDK version from 5.17.0 to 5.17. This allows integrations to use MoPub 5.17.x up to (but not including) 6.0.
    * Service release. No new features. 

* 1.0.0.1
    * Add `fullscreenAdAdapterAdWillPresent` and `fullscreenAdAdapterAdDidPresent` to notify publishers of the fullscreen ad show event. Remove `fullscreenAdAdapterAdWillAppear` and  `fullscreenAdAdapterAdDidAppear` as they are now deprecated by the MoPub iOS SDK.
    * Publishers must use v5.17.0 of the MoPub SDK at the minimum.

* 1.0.0.0
    * Initial release.
    * These are reference adapters designed to test the MoPub mediation protocol. DO NOT USE EXTERNALLY.
