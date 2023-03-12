# file_audio

An audio player with ducking support for local and asset files. 

Link to pub.dev package: [flie_audio](https://pub.dev/packages/file_audio)

## Installation
In the `dependencies` section of the `pubspec.yaml` project file add:

```
file_audio: <latest_version>
```

## Usage

```dart
    FileAudio audioPlayer = FileAudio();

    audioPlayer.playAsset(assetPath);
    
    audioPlayer.start(filePath);

    audioPlayer.stop();

    audioPlayer.pause();

    audioPlayer.resume();
```