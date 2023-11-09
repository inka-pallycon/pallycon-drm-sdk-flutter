package com.pallycon.advanced

import android.app.Activity
import android.os.Build
import android.os.Bundle
import android.view.SurfaceView
import android.widget.Toast
import com.google.android.exoplayer2.ExoPlayer
import com.google.android.exoplayer2.PlaybackException
import com.google.android.exoplayer2.Player
import com.google.android.exoplayer2.source.MediaSource
import com.google.android.exoplayer2.ui.StyledPlayerView
import com.google.android.exoplayer2.util.Util
import com.google.gson.Gson
import com.pallycon.widevine.exception.PallyConException
import com.pallycon.widevine.exception.PallyConLicenseServerException
import com.pallycon.widevine.model.ContentData
import com.pallycon.widevine.model.DownloadState
import com.pallycon.widevine.model.PallyConDrmConfigration
import com.pallycon.widevine.model.PallyConEventListener
import com.pallycon.widevine.sdk.PallyConWvSDK

class PlayerActivity : Activity() {

    private var exoPlayer: ExoPlayer? = null
    private var wvSDK: PallyConWvSDK? = null
    private var playerView: StyledPlayerView? = null

    companion object {
        const val CONTENT_DATA = "CONTENT_DATA"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_player)

        playerView = findViewById(R.id.exoplayer_view)

        // TODO : Set Sercurity API to protect media recording by screen recorder
        val view = playerView!!.videoSurfaceView as SurfaceView
//        val view = binding.surfaceView
        if (Build.VERSION.SDK_INT >= 17) {
            view.setSecure(true)
        }
    }

    fun initializePlayer() {
        if (intent.hasExtra(CONTENT_DATA) &&
            wvSDK == null) {
            val contentDataJson: String = intent.getStringExtra(CONTENT_DATA)!!
            val contentData = Gson().fromJson(contentDataJson, ContentData::class.java)
            wvSDK = PallyConWvSDK.createPallyConWvSDK(
                this,
                contentData
            )
            wvSDK?.setPallyConEventListener(object : PallyConEventListener {
                override fun onCompleted(currentUrl: String?) {
                    print("onComplete : ${currentUrl}")
                }

                override fun onFailed(currentUrl: String?, e: PallyConException?) {
                    print(e?.msg)
                }

                override fun onFailed(currentUrl: String?, e: PallyConLicenseServerException?) {
                    print("code:${e?.errorCode()}, message:${e?.message()}")
                }

                override fun onPaused(currentUrl: String?) {
                    print("onPaused : ${currentUrl}")
                }

                override fun onProgress(
                    currentUrl: String?,
                    percent: Float,
                    downloadedBytes: Long
                ) {
                    print("currentUrl:${currentUrl}, percent:${percent}")
                }

                override fun onRemoved(currentUrl: String?) {
                    print("onRemoved : ${currentUrl}")
                }

                override fun onRestarting(currentUrl: String?) {
                    print("onRestarting : ${currentUrl}")
                }

                override fun onStopped(currentUrl: String?) {
                    print("onStopped : ${currentUrl}")
                }

            })
        }

        checkLicense();
    }

    fun checkLicense() {
        try {
            val drmInfo = wvSDK?.getDrmInformation()
            drmInfo?.let {
                if ((it.licenseDuration <= 0 || it.playbackDuration <= 0) &&
                    wvSDK?.getDownloadState() == DownloadState.COMPLETED) {
                    Toast.makeText(applicationContext, "Expired license", Toast.LENGTH_LONG)
                        .show()
                }
                wvSDK?.getMediaSource()?.let { media ->
                    playContent(media)
                }
            }
        } catch (e: PallyConException.DrmException) {
            print(e)
            wvSDK?.downloadLicense(null, onSuccess = {
                Toast.makeText(applicationContext, "download license", Toast.LENGTH_LONG)
                    .show()
                checkLicense();
            }, onFailed = { e ->
                Toast.makeText(applicationContext, "${e.msg}", Toast.LENGTH_LONG)
                    .show()
            })
        } catch (e: PallyConException.DetectedDeviceTimeModifiedException) {
            print(e)
            Toast.makeText(applicationContext, "DeviceTimeModified", Toast.LENGTH_LONG)
                .show()
        } catch (e: Exception) {
            print(e)
            Toast.makeText(applicationContext, "Exception", Toast.LENGTH_LONG)
                .show()
        }
    }

    fun playContent(mediaSource: MediaSource) {
        ExoPlayer.Builder(this).build()
            .also { player ->
                exoPlayer = player
                playerView?.player = player
                exoPlayer?.setMediaSource(mediaSource)
                exoPlayer?.prepare()
                exoPlayer?.playWhenReady = true
                exoPlayer?.addListener(object : Player.Listener {
                    override fun onPlayerError(error: PlaybackException) {
                        super.onPlayerError(error)
                        if (error.errorCode ==
                            PlaybackException.ERROR_CODE_DRM_LICENSE_EXPIRED) {
                            Toast.makeText(applicationContext, "License Expired", Toast.LENGTH_SHORT).show()
                        } else {
                            Toast.makeText(applicationContext, error.message, Toast.LENGTH_SHORT).show()
                        }
                    }

                    override fun onIsPlayingChanged(isPlaying: Boolean) {
                        super.onIsPlayingChanged(isPlaying)
                        if (isPlaying && exoPlayer != null) {
//                            viewModel.setDuration(exoPlayer!!.duration)
                        }
                    }
                })
            }
    }

    override fun onStart() {
        super.onStart()
        if (Util.SDK_INT > 24 || exoPlayer != null) {
            exoPlayer?.playWhenReady = true
        }
    }

    override fun onResume() {
        super.onResume()
        exoPlayer?.playWhenReady = true
        initializePlayer()
    }

    override fun onStop() {
        super.onStop()
        exoPlayer?.playWhenReady = false
        if (isFinishing) {
            releasePlayer()
        }
    }

    private fun releasePlayer() {
        exoPlayer?.release()
    }
}
