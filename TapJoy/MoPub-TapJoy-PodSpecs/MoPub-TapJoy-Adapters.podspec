#
# Be sure to run `pod lib lint MoPub-TapJoy-Adapters.podspec' to ensure this is a
# valid spec before submitting.
#

Pod::Spec.new do |s|
s.name             = 'MoPub-TapJoy-Adapters'
s.version          = '11.11.1.0'
s.summary          = 'TapJoy Adapters for mediating through MoPub.'
s.description      = <<-DESC
Supported ad formats: Interstitial, Rewarded Video.\n
To download and integrate the TapJoy SDK, please check this tutorial: https://dev.tapjoy.com/sdk-integration/ios/getting-started-guide-publishers-ios/ \n\n
For inquiries and support, please email https://dev.tapjoy.com/contact-support/. \n
DESC
s.homepage         = 'https://github.com/mopub/mopub-ios-mediation'
s.license          = { :type => 'New BSD', :file => 'LICENSE' }
s.author           = { 'PoojaChirp' => 'pshashidhar@twitter.com' }
s.source           = { :git => 'https://github.com/mopub/mopub-ios-mediation.git', :tag => 'master' }
s.ios.deployment_target = '8.0'
s.source_files = 'TapJoy/*.{h,m}'
s.dependency 'mopub-ios-sdk', '~> 4.19.0'
s.dependency 'TapjoySDK', '~> 11.0'
end
