import Flutter
import UIKit
import AVFoundation

public class FileAudioPlugin: NSObject, FlutterPlugin, AVAudioPlayerDelegate {

  private var audioPlayer: AVAudioPlayer?
  private var flutterResult: FlutterResult?
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "file_audio", binaryMessenger: registrar.messenger())
    let instance = FileAudioPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }


    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        flutterResult = result
        
        let action = call.method
        
        if (action == "start") {
            if (call.arguments != nil){
                guard let args = call.arguments as? [String: Any] else {
                  print("Failed to parse call.arguments from Flutter.")
                  return
                }
                let url : String = args["path"] as! String
                let duckOthers : Bool = args["duckOthers"] as! Bool
                start(filePath : url, duck: duckOthers)
            } else {
                print("no file")
                self.flutterResult!(false)
            }
        } else if (action == "stop") {
            stop()
        } else if (action == "pause") {
            pause()
        } else {
            resume()
        }
    }
    
    private func start(filePath: String, duck: Bool){
        let url = URL(string: filePath)
        let avopts:AVAudioSession.CategoryOptions

        if (duck) {
          avopts = [
            .mixWithOthers,
            .duckOthers,
            .interruptSpokenAudioAndMixWithOthers
          ]
        }
        else {
          avopts = [
            .mixWithOthers
          ]
        }

        if (url != nil){
          do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: avopts)
            try AVAudioSession.sharedInstance().setActive(true)
            try audioPlayer = AVAudioPlayer(contentsOf: url!, fileTypeHint: AVFileType.wav.rawValue)

		        audioPlayer!.setVolume(1.0, fadeDuration:0)
            audioPlayer!.delegate = self
            audioPlayer!.play()
          } 
          catch {
              print("start error: \(error)")
              self.flutterResult!(false)
          }
        } 
        else {
          print("url null")
          self.flutterResult!(false)
        }
        
    }
    
    private func stop(){
      do {
        try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        self.flutterResult!(true)
      } catch {
        print("AVAudioSession stop error: \(error)")
        self.flutterResult!(false)
      }
			audioPlayer?.stop()
    }
    
    private func pause(){
        audioPlayer?.pause()
        do {
          try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
          self.flutterResult!(true)
        } catch {
          print("AVAudioSession pause error: \(error)")
          self.flutterResult!(false)
        }
    }
    
    private func resume(){
      do {
          try AVAudioSession.sharedInstance().setActive(true)
          self.flutterResult!(true)
        } catch {
          print("AVAudioSession resume error: \(error)")
          self.flutterResult!(false)
        }
		  audioPlayer?.play()
    }
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
      do {
        try AVAudioSession.sharedInstance().setActive(false,options: .notifyOthersOnDeactivation)
        self.flutterResult!(true)
      } catch {
        print("AVAudioSession audioPlayerDidFinishPlaying error: \(error)")
        self.flutterResult!(false)
      }
    }

}
