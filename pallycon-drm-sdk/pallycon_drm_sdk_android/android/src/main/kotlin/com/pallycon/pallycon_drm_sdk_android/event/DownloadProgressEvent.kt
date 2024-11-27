import com.pallycon.widevine.model.ContentData

interface DownloadProgressEvent {
    fun sendProgressEvent(contentData: ContentData, percent: Float, downloadedBytes: Long)
}