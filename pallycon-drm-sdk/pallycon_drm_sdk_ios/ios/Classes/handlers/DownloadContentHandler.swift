import Flutter
import Foundation

public class DownloadContentHandler: NSObject, FlutterStreamHandler {
    private var events: FlutterEventSink?

    public func startListening() {
        
    }

    public func stopListening() {
//        events?.setStreamHandler(null)
//        events = null
    }

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        // event 연결
        // PallyConSdk.getInstance(it).setDownloadProgress(events)
        self.events = events
        PallyConSdk.shared.setDownloadProgress(eventSink: events)
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        // event 연결 해제
        // PallyConSdk.getInstance(it).setDownloadProgress(null)
        PallyConSdk.shared.setDownloadProgress(eventSink: nil)
        events = nil
        return nil
    }
}

