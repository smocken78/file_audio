import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'file_audio_platform_interface.dart';

/// An implementation of [FileAudioPlatform] that uses method channels.
class MethodChannelFileAudio extends FileAudioPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('file_audio');

  @override
  Future<void> start(String path) async {
    try {
      await methodChannel.invokeMethod("start", path);
    } on PlatformException {
      //print("Stream start error : $e");
    }
  }

  @override
  Future<void> stop() async {
    try {
      await methodChannel.invokeMethod("stop");
    } on PlatformException {
      //print("Stream stop error : $e");
    }
  }

  @override
  Future<void> pause() async {
    try {
      await methodChannel.invokeMethod("pause");
    } on PlatformException {
      //print("Stream pause error : $e");
    }
  }

  @override
  Future<void> resume() async {
    try {
      await methodChannel.invokeMethod("resume");
    } on PlatformException {
      //print("Stream resume error : $e");
    }
  }
}
