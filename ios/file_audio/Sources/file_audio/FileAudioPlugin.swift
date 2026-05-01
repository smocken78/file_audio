import Flutter
import UIKit
import AVFoundation

public class FileAudioPlugin: NSObject, FlutterPlugin, AVAudioPlayerDelegate {

  private var audioPlayer: AVAudioPlayer?
  private var flutterResult: FlutterResult?

  public static func register(with registrar: any FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "file_audio", binaryMessenger: registrar.messenger())
    let instance = FileAudioPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    flutterResult = result

    switch call.method {
    case "start":
      guard let args = call.arguments as? [String: Any],
            let path = args["path"] as? String,
            let duckOthers = args["duckOthers"] as? Bool else {
        print("file_audio: invalid arguments for start")
        result(false)
        return
      }
      start(filePath: path, duck: duckOthers)
    case "stop":
      stop()
    case "pause":
      pause()
    case "resume":
      resume()
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func start(filePath: String, duck: Bool) {
    guard let url = URL(string: filePath) else {
      print("file_audio: invalid URL")
      flutterResult?(false)
      return
    }

    let avopts: AVAudioSession.CategoryOptions = duck
      ? [.mixWithOthers, .duckOthers, .interruptSpokenAudioAndMixWithOthers]
      : [.mixWithOthers]

    do {
      try AVAudioSession.sharedInstance().setCategory(.playback, options: avopts)
      try AVAudioSession.sharedInstance().setActive(true)
      audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
      audioPlayer?.setVolume(1.0, fadeDuration: 0)
      audioPlayer?.delegate = self
      audioPlayer?.play()
    } catch {
      print("file_audio start error: \(error)")
      flutterResult?(false)
    }
  }

  private func stop() {
    audioPlayer?.stop()
    do {
      try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
      flutterResult?(true)
    } catch {
      print("file_audio stop error: \(error)")
      flutterResult?(false)
    }
  }

  private func pause() {
    audioPlayer?.pause()
    do {
      try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
      flutterResult?(true)
    } catch {
      print("file_audio pause error: \(error)")
      flutterResult?(false)
    }
  }

  private func resume() {
    audioPlayer?.play()
    do {
      try AVAudioSession.sharedInstance().setActive(true)
      flutterResult?(true)
    } catch {
      print("file_audio resume error: \(error)")
      flutterResult?(false)
    }
  }

  public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    do {
      try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
      flutterResult?(true)
    } catch {
      print("file_audio finish error: \(error)")
      flutterResult?(false)
    }
  }
}