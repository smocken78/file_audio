#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint file_audio.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'file_audio'
  s.version          = '0.1.0'
  s.summary          = 'A plugin for playing audio files and assets with ducking support for iOS and Android.'
  s.description      = <<-DESC
A Flutter plugin for playing audio files and Flutter asset files with
AVAudioSession ducking support on iOS and AudioFocus management on Android.
                       DESC
  s.homepage         = 'https://github.com/smocken78/file_audio'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'smocken78' => '' }
  s.source           = { :path => '.' }
  # Source files are in the SPM-compatible directory so both CocoaPods and
  # Swift Package Manager share the same implementation files.
  s.source_files     = 'file_audio/Sources/file_audio/**/*.swift'

  # ── CocoaPods dependency ──────────────────────────────────────────────────
  s.dependency 'Flutter'

  # ── Deployment target ─────────────────────────────────────────────────────
  # Flutter itself requires iOS 13 since Flutter 3.19; keep in sync.
  s.ios.deployment_target = '14.0'

  # ── Swift ─────────────────────────────────────────────────────────────────
  s.swift_version = '5.9'

  # ── Build settings ────────────────────────────────────────────────────────
  # DEFINES_MODULE is required so the Swift class is visible to ObjC generated
  # by the Flutter plugin registrant.  No i386 slice in Flutter.framework.
  s.pod_target_xcconfig = {
    'DEFINES_MODULE'                        => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]'  => 'i386'
  }
end
