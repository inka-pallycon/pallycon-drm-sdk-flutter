package com.pallycon.pallycon_drm_sdk_android

import android.content.Context
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

class PallyConDrmSdkAndroidPlugin: FlutterPlugin, ActivityAware {

//    private lateinit var channel : MethodChannel
    private lateinit var applicationContext: Context

    private var methodCallHandler: MethodCallHandlerImpl? = null
    private var downloadChangeHandler: DownloadContentHandler? = null
    private var drmMessageHandler: PallyConEventHandler? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        Log.d("PallyConWvSdk", "onAttached")

        applicationContext = binding.applicationContext

        methodCallHandler = MethodCallHandlerImpl()
        methodCallHandler?.startListening(applicationContext, binding.binaryMessenger)

        drmMessageHandler = PallyConEventHandler()
        drmMessageHandler?.startListening(applicationContext, binding.binaryMessenger)

        downloadChangeHandler = DownloadContentHandler()
        downloadChangeHandler?.startListening(applicationContext, binding.binaryMessenger)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
//        binding.applicationContext.unbindService()
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        methodCallHandler?.let {
            it.setActivity(binding.activity)
            binding.addRequestPermissionsResultListener(it)
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {
        methodCallHandler?.setActivity(null)
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        methodCallHandler?.let {
            it.setActivity(binding.activity)
            binding.addRequestPermissionsResultListener(it)
        }
    }

    override fun onDetachedFromActivity() {
        methodCallHandler?.setActivity(null)
    }
}
