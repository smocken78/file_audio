import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'file_audio_method_channel.dart';

abstract class FileAudioPlatform extends PlatformInterface {
  /// Constructs a FileAudioPlatform.
  FileAudioPlatform() : super(token: _token);

  static final Object _token = Object();

  static FileAudioPlatform _instance = MethodChannelFileAudio();

  /// The default instance of [FileAudioPlatform] to use.
  ///
  /// Defaults to [MethodChannelFileAudio].
  static FileAudioPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FileAudioPlatform] when
  /// they register themselves.
  static set instance(FileAudioPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> start(String path) async {
    throw UnimplementedError('start(String path) has not been implemented.');
  }

  Future<void> stop() async {
    throw UnimplementedError('stop() has not been implemented.');
  }

  Future<void> pause() async {
    throw UnimplementedError('pause() has not been implemented.');
  }

  Future<void> resume() async {
    throw UnimplementedError('resume() has not been implemented.');
  }
}
