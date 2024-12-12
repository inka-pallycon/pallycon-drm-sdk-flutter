import Foundation
import UIKit
import AVKit
import Flutter
import PallyConFPSSDK

@main
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
        let userId = drmJson["userId"] as? String ?? "utest"

        // 1. PallyCon FPS SDK initialize
        pallyconSdk = try? PallyConFPSSDK(siteId: siteId, siteKey: "", fpsLicenseDelegate: self)
        guard let contentUrl = URL(string: url) else {
            return
        }
        
        let urlAsset = AVURLAsset(url: contentUrl)
        
        // 2. Acquire a Token information
        pallyconSdk?.prepare(urlAsset: urlAsset, userId: userId, contentId: contentId, token: token, licenseUrl: drmLicenseUrl)
        
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
    func fpsLicenseDidSuccessAcquiring(contentId: String) {
        print("License Success : \(contentId)")
    }
    
    func fpsLicense(contentId: String, didFailWithError error: Error) {
        print("License Fail Error : \(contentId)")
    }
}
