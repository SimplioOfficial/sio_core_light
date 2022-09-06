#import "SioCoreLightPlugin.h"
#if __has_include(<sio_core_light/sio_core_light-Swift.h>)
#import <sio_core_light/sio_core_light-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "sio_core_light-Swift.h"
#endif

@implementation SioCoreLightPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSioCoreLightPlugin registerWithRegistrar:registrar];
}
@end
