#import "ChecarConeccaoPlugin.h"
#if __has_include(<checar_coneccao_plugin/checar_coneccao_plugin-Swift.h>)
#import <checar_coneccao_plugin/checar_coneccao_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "checar_coneccao_plugin-Swift.h"
#endif

@implementation ChecarConeccaoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftChecarConeccaoPlugin registerWithRegistrar:registrar];
}
@end
