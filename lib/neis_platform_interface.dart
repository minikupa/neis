import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'neis_method_channel.dart';

abstract class NeisPlatform extends PlatformInterface {
  /// Constructs a NeisPlatform.
  NeisPlatform() : super(token: _token);

  static final Object _token = Object();

  static NeisPlatform _instance = MethodChannelNeis();

  /// The default instance of [NeisPlatform] to use.
  ///
  /// Defaults to [MethodChannelNeis].
  static NeisPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NeisPlatform] when
  /// they register themselves.
  static set instance(NeisPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
