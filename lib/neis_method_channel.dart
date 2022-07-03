import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'neis_platform_interface.dart';

/// An implementation of [NeisPlatform] that uses method channels.
class MethodChannelNeis extends NeisPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('neis');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
