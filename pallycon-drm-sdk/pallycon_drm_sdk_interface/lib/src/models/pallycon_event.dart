import '../enums/enums.dart';

class PallyConEvent {
  /// Creates an instance of [PallyConEvent].
  ///
  /// The [eventType] and [url] arguments is required.
  ///
  /// arguments can be null.
  PallyConEvent(
      {required this.eventType,
      required this.contentId,
      required this.url,
      this.errorCode,
      this.message});

  /// The type of the event.
  final PallyConEventType eventType;

  final String contentId;

  final String url;

  final String? errorCode;

  final String? message;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PallyConEvent &&
            runtimeType == other.runtimeType &&
            contentId == other.contentId &&
            url == other.url &&
            eventType == other.eventType &&
            errorCode == other.errorCode &&
            message == other.message;
  }

  @override
  int get hashCode =>
      eventType.hashCode ^
      contentId.hashCode ^
      url.hashCode ^
      errorCode.hashCode ^
      message.hashCode;

  static PallyConEvent fromMap(dynamic message) {
    final Map<dynamic, dynamic> pallyConEvent = message;

    if (!pallyConEvent.containsKey('contentId')) {
      throw ArgumentError.value(pallyConEvent, 'contentId',
          'The supplied map doesn\'t contain the mandatory key `contentId`.');
    }

    if (!pallyConEvent.containsKey('url')) {
      throw ArgumentError.value(pallyConEvent, 'url',
          'The supplied map doesn\'t contain the mandatory key `url`.');
    }

    if (!pallyConEvent.containsKey('eventType')) {
      throw ArgumentError.value(pallyConEvent, 'eventType',
          'The supplied map doesn\'t contain the mandatory key `eventType`.');
    }

    final String? eventType = pallyConEvent['eventType'] as String?;
    switch (eventType) {
      case 'prepare':
        return PallyConEvent(
            eventType: PallyConEventType.prepare,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'complete':
        return PallyConEvent(
            eventType: PallyConEventType.complete,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'pause':
        return PallyConEvent(
            eventType: PallyConEventType.pause,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'remove':
        return PallyConEvent(
            eventType: PallyConEventType.remove,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'stop':
        return PallyConEvent(
            eventType: PallyConEventType.stop,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'contentDataError':
        return PallyConEvent(
            eventType: PallyConEventType.contentDataError,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'drmError':
        return PallyConEvent(
            eventType: PallyConEventType.drmError,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'licenseServerError':
        return PallyConEvent(
            eventType: PallyConEventType.licenseServerError,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            errorCode: pallyConEvent['errorCode'],
            message: pallyConEvent['message']);
      case 'downloadError':
        return PallyConEvent(
            eventType: PallyConEventType.downloadError,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'networkConnectedError':
        return PallyConEvent(
            eventType: PallyConEventType.networkConnectedError,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'detectedDeviceTimeModifiedError':
        return PallyConEvent(
            eventType: PallyConEventType.detectedDeviceTimeModifiedError,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'migrationError':
        return PallyConEvent(
            eventType: PallyConEventType.migrationError,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'licenseCipherError':
        return PallyConEvent(
            eventType: PallyConEventType.licenseCipherError,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      default:
        return PallyConEvent(
            eventType: PallyConEventType.unknown,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
    }
  }
}
