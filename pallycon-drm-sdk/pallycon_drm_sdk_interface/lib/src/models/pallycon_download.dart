class PallyConDownload {
  const PallyConDownload(
      {required this.url,
      required this.percent,
      required this.downloadedBytes});

  final String url;
  final double percent;
  final int downloadedBytes;

  static PallyConDownload fromMap(dynamic message) {
    final Map<dynamic, dynamic> pallyConDownloadMap = message;

    if (!pallyConDownloadMap.containsKey('url')) {
      throw ArgumentError.value(pallyConDownloadMap, 'url',
          'The supplied map doesn\'t contain the mandatory key `url`.');
    }

    if (!pallyConDownloadMap.containsKey('percent')) {
      throw ArgumentError.value(pallyConDownloadMap, 'percent',
          'The supplied map doesn\'t contain the mandatory key `percent`.');
    }

    if (!pallyConDownloadMap.containsKey('downloadedBytes')) {
      throw ArgumentError.value(pallyConDownloadMap, 'downloadedBytes',
          'The supplied map doesn\'t contain the mandatory key `downloadedBytes`.');
    }

    return PallyConDownload(
        url: pallyConDownloadMap['url'],
        percent: pallyConDownloadMap['percent'],
        downloadedBytes: pallyConDownloadMap['downloadedBytes']);
  }
}
