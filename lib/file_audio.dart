import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'file_audio_platform_interface.dart';

class FileAudio {
  final Map<String, File> _assetCache = <String, File>{};
  final bool duckOthers;

  FileAudio({
    this.duckOthers = true,
  });

  loadAssets(List<String> fileNames) async {
    for (var element in fileNames) {
      File f = await _fetchToMemory(element);
      _assetCache[element] = f;
    }
  }

  cleanUp() async {
    for (var element in _assetCache.keys) {
      _assetCache[element]!.delete();
    }
    _assetCache.clear();
  }

  Future<File> _fetchToMemory(String fileName) async {
    final file = File('${(await getTemporaryDirectory()).path}/$fileName');
    await file.create(recursive: true);
    return await file
        .writeAsBytes((await _fetchAsset(fileName)).buffer.asUint8List());
  }

  Future<ByteData> _fetchAsset(String fileName) async {
    return await rootBundle.load(fileName);
  }

  Future<void> playAsset(String asset) async {
    start(_assetCache[asset]!.path);
  }

  Future<void> start(String path) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args["path"] = path;
    args["duckOthers"] = duckOthers;
    FileAudioPlatform.instance.start(args);
  }

  Future<void> stop() async {
    FileAudioPlatform.instance.stop();
  }

  Future<void> pause() async {
    FileAudioPlatform.instance.pause();
  }

  Future<void> resume() async {
    FileAudioPlatform.instance.resume();
  }
}
