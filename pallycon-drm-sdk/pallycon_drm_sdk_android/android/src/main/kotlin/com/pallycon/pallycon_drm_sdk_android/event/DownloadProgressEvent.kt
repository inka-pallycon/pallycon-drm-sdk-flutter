interface DownloadProgressEvent {
    fun sendProgressEvent(url: String, percent: Float, downloadedBytes: Long)
}