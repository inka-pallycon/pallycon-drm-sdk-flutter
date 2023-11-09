import com.pallycon.pallycon_drm_sdk_android.models.EventType

interface PallyConEvent {
    fun sendPallyConEvent(url: String, eventType: EventType, message: String, errorCode: String = "")
}