import android.os.Looper
import com.pallycon.pallycon_drm_sdk_android.models.ProgressMessage
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class DownloadProgressEventImpl(
    private var progressEvent: EventChannel.EventSink?
): DownloadProgressEvent {

    override fun sendProgressEvent(url: String, percent: Float, downloadedBytes: Long) {
        if (Looper.getMainLooper().thread == Thread.currentThread()) {
            progressEvent?.success(
                ProgressMessage(
                    url,
                    percent,
                    downloadedBytes
                ).toMap()
            )
        } else {
            GlobalScope.launch(Dispatchers.Main) {
                progressEvent?.success(
                    ProgressMessage(
                        url,
                        percent,
                        downloadedBytes
                    ).toMap()
                )
            }
        }
    }
}
