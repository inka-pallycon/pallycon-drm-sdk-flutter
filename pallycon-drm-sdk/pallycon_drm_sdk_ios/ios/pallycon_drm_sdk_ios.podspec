#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint pallycon_drm_sdk_ios.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'pallycon_drm_sdk_ios'
  s.version          = '1.2.0'
  s.summary          = 'PallyCon DRM Flutter SDK for iOS.'
  s.description      = <<-DESC
A new Flutter PallyCon FairPlay Streaming(FPS) SDK plugin project.
                       DESC
  s.homepage         = 'http://www.pallycon.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'INKA Entworks' => 'yhpark@inka.co.kr' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'PallyConFPSSDK'
#   s.dependency 'PallyConFPSSDK', :podspec => './PallyConFPSSDK/PallyConFPSSDK.podspec'
#   s.subspec "PallyConFPSSDK" do |sp|
#     sp.framework   = 'CoreFoundation'
#     sp.dependency   'PallyConFPSSDK', :path => "./PallyConFPSSDK/"
#   end
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
