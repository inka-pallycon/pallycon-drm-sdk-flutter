import android.os.Looper
import com.pallycon.pallycon_drm_sdk_android.models.EventMessage
import com.pallycon.pallycon_drm_sdk_android.models.EventType
import com.pallycon.pallycon_drm_sdk_android.models.ProgressMessage
import com.pallycon.pallycon_drm_sdk_android.sdk.PallyConSdk
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class PallyConEventImpl(
    private var pallyConEvent: EventChannel.EventSink?
): PallyConEvent {

    override fun sendPallyConEvent(
        url: String,
        eventType: EventType,
        message: String,
        errorCode: String
    ) {
        if (Looper.getMainLooper().thread == Thread.currentThread()) {
            pallyConEvent?.success(
                EventMessage(
                    eventType,
                    url,
                    message,
                    errorCode
                ).toMap()
            )
        } else {
            GlobalScope.launch(Dispatchers.Main) {
                pallyConEvent?.success(
                    EventMessage(
                        eventType,
                        url,
                        message,
                        errorCode
                    ).toMap()
                )
            }
        }
    }
}
