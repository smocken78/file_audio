#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint ios/file_audio.podspec --configuration=Debug --skip-tests --use-modular-headers`
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
  s.license          = { :type => 'GPL-3.0', :file => '../LICENSE' }
  s.author           = { 'smocken78' => '' }

  # :path is for local development; published versions use :git + :tag
  s.source           = { :git => 'https://github.com/smocken78/file_audio.git', :tag => s.version.to_s }

  # Source files shared with SPM (same path, no duplication)
  s.source_files     = 'file_audio/Sources/file_audio/**/*.swift'

  s.dependency 'Flutter'

  s.ios.deployment_target = '13.0'
  s.swift_version         = '5.9'

  s.pod_target_xcconfig = {
    'DEFINES_MODULE'                        => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]'  => 'i386'
  }
end