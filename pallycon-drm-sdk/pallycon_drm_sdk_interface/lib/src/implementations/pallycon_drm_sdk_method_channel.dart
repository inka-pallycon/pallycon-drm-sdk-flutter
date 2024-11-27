import 'package:flutter/services.dart';

import '../models/models.dart';
import '../pallycon_drm_sdk_interface.dart';
import '../enums/pallycon_download_state.dart';

/// An implementation of [PallyConDrmSdkPlatform] that uses method channels.
class MethodChannelPallyConDrmSdk extends PallyConDrmSdkPlatform {
  static const _methodChannel = MethodChannel('com.pallycon.drmsdk');

  static const _pallyConEventChannel =
      EventChannel('com.pallycon.drmsdk/pallycon_event');

  static const _downloadProgressChannel =
      EventChannel('com.pallycon.drmsdk/download_progress');

  Stream<PallyConEvent>? _pallyConEventStream;
  Stream<PallyConDownload>? _downloadProgressStream;

  @override
  Future<void> initialize(String siteId) async {
    await _methodChannel.invokeMethod('initialize', {'siteId': siteId});
  }

  @override
  void release() {
    _methodChannel.invokeMethod('release');
  }

  @override
  Future<String> getObjectForContent(
      PallyConContentConfiguration config) async {
    return await _methodChannel.invokeMethod(
        'getObjectForContent', _configToDynamicList(config));
  }

  @override
  Future<PallyConDownloadState> getDownloadState(
      PallyConContentConfiguration config) async {
    final String state = await _methodChannel.invokeMethod(
        'getDownloadState', _configToDynamicList(config));

    var pallyConDownloadState = PallyConDownloadState.NOT;
    switch (state) {
      case "DOWNLOADING":
        {
          pallyConDownloadState = PallyConDownloadState.DOWNLOADING;
        }
        break;
      case "COMPLETED":
        {
          pallyConDownloadState = PallyConDownloadState.COMPLETED;
        }
        break;
      case "PAUSED":
        {
          pallyConDownloadState = PallyConDownloadState.PAUSED;
        }
        break;
      default:
        {
          pallyConDownloadState = PallyConDownloadState.NOT;
        }
        break;
    }

    return pallyConDownloadState;
  }

  // Delegate
  @override
  Stream<PallyConEvent> get onPallyConEvent {
    if (_pallyConEventStream != null) {
      return _pallyConEventStream!;
    }
    var pallyConEventStream = _pallyConEventChannel.receiveBroadcastStream();

    _pallyConEventStream = pallyConEventStream
        .where((pallyConEvent) => pallyConEvent != null)
        .map((dynamic element) =>
            PallyConEvent.fromMap(element.cast<String, dynamic>()))
        .handleError((error) {
      _pallyConEventStream = null;
      if (error is PlatformException) {
        error = _handlePlatformException(error);
      }
      throw error;
    });

    return _pallyConEventStream!;
  }

  @override
  Stream<PallyConDownload> get onDownloadProgress {
    if (_downloadProgressStream != null) {
      return _downloadProgressStream!;
    }

    var downloadProgressStream =
        _downloadProgressChannel.receiveBroadcastStream();

    _downloadProgressStream = downloadProgressStream
        .where((pallyConDownload) => pallyConDownload != null)
        .map((dynamic element) =>
            PallyConDownload.fromMap(element.cast<String, dynamic>()))
        .handleError((error) {
      _downloadProgressStream = null;
      if (error is PlatformException) {
        error = _handlePlatformException(error);
      }
      throw error;
    });

    return _downloadProgressStream!;
  }

  // Download
  @override
  void addStartDownload(PallyConContentConfiguration config) {
    _methodChannel.invokeMethod(
        'addStartDownload', _configToDynamicList(config));
  }

  @override
  void stopDownload(PallyConContentConfiguration config) {
    _methodChannel.invokeMethod('stopDownload', _configToDynamicList(config));
  }

  @override
  void resumeDownloads() {
    _methodChannel.invokeMethod('resumeDownloads');
  }

  @override
  void cancelDownloads() {
    _methodChannel.invokeMethod('cancelDownloads');
  }

  @override
  void pauseDownloads() {
    _methodChannel.invokeMethod('pauseDownloads');
  }

  @override
  void removeDownload(PallyConContentConfiguration config) {
    _methodChannel.invokeMethod('removeDownload', _configToDynamicList(config));
  }

  @override
  void removeLicense(PallyConContentConfiguration config) {
    _methodChannel.invokeMethod('removeLicense', _configToDynamicList(config));
  }

  @override
  Future<bool> needsMigrateDatabase(PallyConContentConfiguration config) async {
    try {
      return await _methodChannel.invokeMethod(
          'needsMigrateDatabase', _configToDynamicList(config));
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  Future<bool> migrateDatabase(PallyConContentConfiguration config) async {
    try {
      return await _methodChannel.invokeMethod(
          'migrateDatabase', _configToDynamicList(config));
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  Future<bool> reDownloadCertification(
      PallyConContentConfiguration config) async {
    try {
      return await _methodChannel.invokeMethod(
          'reDownloadCertification', _configToDynamicList(config));
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  Future<bool> updateSecureTime() async {
    try {
      return await _methodChannel.invokeMethod('updateSecureTime');
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  dynamic _configToDynamicList(PallyConContentConfiguration config) {
    return {
      'contentId': config.contentId,
      'url': config.contentUrl,
      'drmType': config.drmType,
      'token': config.token,
      'customData': config.customData,
      'contentCookie': config.contentCookie,
      'contentHttpHeaders': config.contentHttpHeaders,
      'licenseCookie': config.licenseCookie,
      'licenseHttpHeaders': config.licenseHttpHeaders,
      'licenseUrl': config.licenseUrl,
      'certificateUrl': config.certificateUrl,
      'licenseCipherTablePath': config.licenseCipherTablePath
    };
  }

  Exception _handlePlatformException(PlatformException exception) {
    switch (exception.code) {
      case 'Message':
      default:
        return exception;
    }
  }
}
