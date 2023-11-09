package com.pallycon.pallycon_drm_sdk_android

import DownloadProgressEventImpl
import PallyConEventImpl
import android.content.Context
//import com.google.android.exoplayer2.offline.DownloadService
import com.pallycon.pallycon_drm_sdk_android.sdk.PallyConSdk
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel

class DownloadContentHandler: EventChannel.StreamHandler {
    private var channel: EventChannel? = null
    private var context: Context? = null

    fun startListening(context: Context, messenger: BinaryMessenger) {
        if (channel != null) {
            stopListening()
        }

        channel = EventChannel(messenger, "com.pallycon.drmsdk/download_progress")
        channel?.setStreamHandler(this)
        this.context = context

//        try {
//            DownloadService.start(context, DownloadContentService::class.java)
//        } catch (e: IllegalStateException) {
//            DownloadService.startForeground(context, DownloadContentService::class.java)
//        }
    }

    fun stopListening() {
        channel?.setStreamHandler(null)
        channel = null
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        context?.let {
//            PallyConSdk.getInstance(it).setDownloadProgress(events)
            PallyConSdk.getInstance(it).setDownloadProgressEvent(DownloadProgressEventImpl(events))
        }

    }

    override fun onCancel(arguments: Any?) {
        context?.let {
            PallyConSdk.getInstance(it).setDownloadProgressEvent(null)
        }
    }
}
