import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'file_audio_platform_interface.dart';

class FileAudio {
  ///cache Map for faster access to asset files
  final Map<String, File> _assetCache = <String, File>{};

  ///enable ducking support default:true
  final bool duckOthers;

  FileAudio({
    this.duckOthers = true,
  });

  ///Method creates a cache from List of given assets (e.g. assets/5to0.mp3)
  loadAssets(List<String> fileNames) async {
    for (var element in fileNames) {
      File f = await _fetchToMemory(element);
      _assetCache[element] = f;
    }
  }

  ///deletes all cache entries
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

  ///Starts playing given asset audio file from cache
  ///Files which are not inside the cache will be added
  Future<void> playAsset(String asset) async {
    if (_assetCache[asset] != null) {
      start(_assetCache[asset]!.path);
    } else {
      loadAssets(
        [
          asset,
        ],
      );
      start(_assetCache[asset]!.path);
    }
  }

  ///Starts playing non asset audio file
  Future<void> start(String path) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args["path"] = path;
    args["duckOthers"] = duckOthers;
    FileAudioPlatform.instance.start(args);
  }

  ///stops the currently playing audio
  Future<void> stop() async {
    FileAudioPlatform.instance.stop();
  }

  ///pauses the currently playing audio
  Future<void> pause() async {
    FileAudioPlatform.instance.pause();
  }

  ///resumes the currently playing audio
  Future<void> resume() async {
    FileAudioPlatform.instance.resume();
  }
}
