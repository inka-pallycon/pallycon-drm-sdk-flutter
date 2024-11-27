import Flutter
import UIKit

public class SwiftPallyConDrmSdkIosPlugin: NSObject, FlutterPlugin {
    private var methodCallHandler: MethodCallHandler?
    private var downloadContentHandler: DownloadContentHandler?
    private var pallyConEventHandier: PallyConEventHandler?

    init(_ messenger: FlutterBinaryMessenger, _ registrar: FlutterPluginRegistrar) {
        super.init()
        let methodChannel = FlutterMethodChannel(name: "com.pallycon.drmsdk/ios", binaryMessenger: registrar.messenger())

        let pallyConEventChannel = FlutterEventChannel(name: "com.pallycon.drmsdk/pallycon_event", binaryMessenger: messenger)

        let downloadProgressChannel = FlutterEventChannel(name: "com.pallycon.drmsdk/download_progress", binaryMessenger: messenger)
        registrar.addMethodCallDelegate(self, channel: methodChannel)

        methodCallHandler = MethodCallHandler()

        self.pallyConEventHandier = PallyConEventHandler()
        pallyConEventChannel.setStreamHandler(self.pallyConEventHandier)

        self.downloadContentHandler = DownloadContentHandler()
        downloadProgressChannel.setStreamHandler(downloadContentHandler)
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        //     let channel = FlutterMethodChannel(name: "com.pallycon.drmsdk/ios", binaryMessenger: registrar.messenger())
        //     let drmMessageEventChannel = FlutterEventChannel(name: "com.pallycon.drmsdk/drm_message_ios", binaryMessenger: registrar.messenger())
        //     let downloadChangeEventChannel = FlutterEventChannel(name: "com.pallycon.drmsdk/download_change_ios", binaryMessenger: registrar.messenger())
        //
        //     let instance = SwiftPallyconDrmSdkIosPlugin()
        //     instance.channel = channel
        //     registrar.addMethodCallDelegate(instance, channel: channel)
        //     drmMessageEventSink.setStreamHandler(instance)
        //     downloadChangeEventSink.setStreamHandler(instance)
        //      methodCallHandler = MethodCallHandler()

        //      methodCallHandler?.startListening(applicationContext, binding.binaryMessenger)

        //      pallyConEventHandier = PallyConEventHandler()
        //      pallyConEventHandier?.startListening(applicationContext, binding.binaryMessenger)

        //      downloadContentHandler = DownloadContentHandler()
        //      downloadContentHandler?.startListening(applicationContext, binding.binaryMessenger)
        let messenger: FlutterBinaryMessenger = registrar.messenger()
        let instance = SwiftPallyConDrmSdkIosPlugin.init(messenger, registrar)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initialize" :
            methodCallHandler?.onInitialize(call, result: result)
        case "release" :
            methodCallHandler?.onRelease()
        case "getObjectForContent" :
            methodCallHandler?.onGetObjectForContent(call, result: result)
        case "getDownloadState" :
            methodCallHandler?.onGetDownloadState(call, result: result)
        case "addStartDownload" :
            methodCallHandler?.onAddDownload(call, result: result)
        case "stopDownload" :
            methodCallHandler?.onStopDownload(call, result: result)
        case "resumeDownloads" :
            methodCallHandler?.onResumeDownloads()
        case "cancelDownloads" :
            methodCallHandler?.onCancelDownloads()
        case "pauseDownloads" :
            methodCallHandler?.onPauseDownloads()
        case "resumeDownloadTask" :
            methodCallHandler?.onResumeDownloadTask(call, result: result)
        case "cancelDownloadTask" :
            methodCallHandler?.onCancelDownloadTask(call, result: result)
        case "removeDownload" :
            methodCallHandler?.onRemoveDownload(call)
        case "removeLicense" :
            methodCallHandler?.onRemoveLicense(call)
        case "needsMigrateDatabase":
            methodCallHandler?.onNeedsMigrateDatabase(call, result: result)
        case "migrateDatabase":
            methodCallHandler?.onMigrateDatabase(call, result: result)
        case "reDownloadCertification":
            methodCallHandler?.onReDownloadCertification()
        case "updateSecureTime":
            methodCallHandler?.onUpdateSecureTime()
        default:
            print("not define handle = " + call.method)
        }
    }

}
