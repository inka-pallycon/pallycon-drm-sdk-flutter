#import "PallyconDrmSdkIosPlugin.h"
#if __has_include(<pallycon_drm_sdk_ios/pallycon_drm_sdk_ios-Swift.h>)
#import <pallycon_drm_sdk_ios/pallycon_drm_sdk_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "pallycon_drm_sdk_ios-Swift.h"
#endif

@implementation PallyConDrmSdkIosPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPallyConDrmSdkIosPlugin registerWithRegistrar:registrar];
}
@end
