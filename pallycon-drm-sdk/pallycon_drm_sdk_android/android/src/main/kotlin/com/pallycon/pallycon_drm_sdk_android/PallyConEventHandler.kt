package com.pallycon.pallycon_drm_sdk_android

import PallyConEventImpl
import android.content.Context
import android.util.Log
import com.pallycon.pallycon_drm_sdk_android.sdk.PallyConSdk
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel

class PallyConEventHandler: EventChannel.StreamHandler {
    private var channel: EventChannel? = null
    private var context: Context? = null

    fun startListening(context: Context, messenger: BinaryMessenger) {
        if (channel != null) {
            stopListening()
        }

        print("DrmSdkHandler startListening")
        channel = EventChannel(messenger, "com.pallycon.drmsdk/pallycon_event")
        channel?.setStreamHandler(this)
        this.context = context
    }

    fun stopListening() {
        channel?.setStreamHandler(null)
        channel = null
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        context?.let {
//            PallyConSdk.getInstance(it).setPallyConEventSink(events)
            PallyConSdk.getInstance(it).setPallyConEvent(PallyConEventImpl(events))
        }

    }

    override fun onCancel(arguments: Any?) {
        context?.let {
            PallyConSdk.getInstance(it).setPallyConEvent(null)
        }
    }

}