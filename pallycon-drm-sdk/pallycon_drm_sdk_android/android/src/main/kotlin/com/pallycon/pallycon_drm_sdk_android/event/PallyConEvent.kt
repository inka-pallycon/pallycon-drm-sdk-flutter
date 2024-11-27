import com.pallycon.pallycon_drm_sdk_android.models.EventType
import com.pallycon.widevine.model.ContentData

interface PallyConEvent {
    fun sendPallyConEvent(
        contentData: ContentData,
        eventType: EventType,
        message: String,
        errorCode: String = "",
    )

    fun sendPallyConEvent(
        contentId: String,
        url: String,
        eventType: EventType,
        message: String,
        errorCode: String = "",
    )
}