import android.os.Looper
import com.pallycon.pallycon_drm_sdk_android.models.EventMessage
import com.pallycon.pallycon_drm_sdk_android.models.EventType
import com.pallycon.widevine.model.ContentData
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class PallyConEventImpl(
    private var pallyConEvent: EventChannel.EventSink?
): PallyConEvent {

    override fun sendPallyConEvent(
        contentData: ContentData,
        eventType: EventType,
        message: String,
        errorCode: String
    ) {
        sendPallyConEvent(contentData.contentId ?: "",
            contentData.url ?: "",
            eventType,
            message,
            errorCode)
    }

    override fun sendPallyConEvent(
        contentId: String,
        url: String,
        eventType: EventType,
        message: String,
        errorCode: String
    ) {
        if (Looper.getMainLooper().thread == Thread.currentThread()) {
            pallyConEvent?.success(
                EventMessage(
                    eventType,
                    contentId ?: "",
                    url ?: "",
                    message,
                    errorCode
                ).toMap()
            )
        } else {
            GlobalScope.launch(Dispatchers.Main) {
                pallyConEvent?.success(
                    EventMessage(
                        eventType,
                        contentId ?: "",
                        url ?: "",
                        message,
                        errorCode
                    ).toMap()
                )
            }
        }
    }
}
