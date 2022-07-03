#import "NeisPlugin.h"
#if __has_include(<neis/neis-Swift.h>)
#import <neis/neis-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "neis-Swift.h"
#endif

@implementation NeisPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNeisPlugin registerWithRegistrar:registrar];
}
@end
