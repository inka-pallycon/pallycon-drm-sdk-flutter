import Foundation
import UIKit
import AVKit
import Flutter
import PallyConFPSSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var pallyconSdk: PallyConFPSSDK?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let pallyconChannel = FlutterMethodChannel(name: "com.pallycon/startActivity",
                                                   binaryMessenger: controller.binaryMessenger)
        
        pallyconChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            guard call.method == "StartSecondActivity" else {
                result(FlutterMethodNotImplemented)
                return
            }
            let arguments: String = call.arguments as! String
            self?.startPlay(jsonString: arguments, flutterViewController: controller)
        })
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func startPlay(jsonString: String, flutterViewController: FlutterViewController) {
        guard let json = try? JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: []) as? [String: Any] else {
            return
        }
        
        guard let url = json["url"] as? String, let drmJson = json["drmConfig"] as? [String: Any] else {
            print("URL or DRM Configuration is nil!")
            return
        }
        
        let contentId = drmJson["contentId"] as? String ?? ""
        let drmLicenseUrl = drmJson["drmLicenseUrl"] as? String ?? ""
        let siteId = drmJson["siteId"] as? String ?? ""
        let token = drmJson["token"] as? String ?? ""

        // 1. PallyCon FPS SDK initialize
        pallyconSdk = PallyConFPSSDK()
        guard let contentUrl = URL(string: url) else {
            return
        }
        
        let urlAsset = AVURLAsset(url: contentUrl)
        
        // 2. Acquire a Token information
        let drm_content = PallyConDrmConfiguration(avURLAsset: urlAsset,
                                                   contentId: contentId,
                                                   certificateUrl: "https://license-global.pallycon.com/ri/fpsKeyManager.do?siteId=\(siteId)",
                                                   authData: token)
        pallyconSdk?.prepare(Content: drm_content)
        
        let playerItem = AVPlayerItem(asset: urlAsset)
        let avPlayer = AVPlayer(playerItem: playerItem)
        let playerView = AVPlayerViewController()
        playerView.player = avPlayer
        flutterViewController.present(playerView, animated: true, completion: {
            avPlayer.play()
        })
    }
}

extension AppDelegate: PallyConFPSLicenseDelegate {
    func license(result: PallyConResult) {
        print("Content ID : \(result.contentId)")
        print("Success    : \(result.isSuccess)")
        print("Error      : \(result.getPallyConErrorForObjC())")
    }
}
