import 'dart:async';
import 'dart:io';

import 'package:file_audio/file_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FileAudio player = FileAudio(duckOthers: false);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            TextButton(
              child: const Text("Start"),
              onPressed: () {
                start();
              },
            ),
            TextButton(
              child: const Text("Stop"),
              onPressed: () {
                stop();
              },
            ),
            TextButton(
              child: const Text("Pause"),
              onPressed: () {
                pause();
              },
            ),
            TextButton(
              child: const Text("Resume"),
              onPressed: () {
                resume();
              },
            )
          ],
        )),
      ),
    );
  }

  Future<void> start() async {
    final ByteData data = await rootBundle.load('assets/5To0.mp3');
    Directory tempDir = await getApplicationDocumentsDirectory();
    File tempFile = File('${tempDir.path}/5To0.mp3');
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
    String mp3Uri = tempFile.uri.toString();

    print("start");

    await player.start(mp3Uri);

    print("end");
  }

  Future<void> stop() async {
    await player.stop();
  }

  Future<void> pause() async {
    await player.pause();
  }

  Future<void> resume() async {
    await player.resume();
  }
}
