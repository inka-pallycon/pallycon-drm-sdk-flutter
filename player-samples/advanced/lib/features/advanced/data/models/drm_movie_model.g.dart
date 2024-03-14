// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drm_movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrmMovieModel _$DrmMovieModelFromJson(Map<String, dynamic> json) =>
    DrmMovieModel(
      json['url'] as String,
      json['content_type'] as String,
      json['stream_format'] as String,
      json['media_type'] as String,
      json['title'] as String,
      json['content_id'] as String,
      json['video_codec'] as String,
      json['video_profile'] as String,
      json['maximum_resolution'] as String,
      json['frame_rate'] as String,
      json['container_format'] as String,
      json['audio_codec'] as String,
      json['audio_language'] as String,
      json['license_server_url'] as String?,
      json['license_cipher_path'] as String?,
      json['license_cert_url'] as String?,
      json['token'] as String?,
      $enumDecodeNullable(_$DownloadStatusEnumMap, json['downloadStatus']),
    );

Map<String, dynamic> _$DrmMovieModelToJson(DrmMovieModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'content_type': instance.contentType,
      'stream_format': instance.streamFormat,
      'media_type': instance.mediaType,
      'title': instance.title,
      'content_id': instance.contentId,
      'video_codec': instance.videoCodec,
      'video_profile': instance.videoProfile,
      'maximum_resolution': instance.maximumResolution,
      'frame_rate': instance.frameRate,
      'container_format': instance.containerFormat,
      'audio_codec': instance.audioCodec,
      'audio_language': instance.audioLanguage,
      'license_server_url': instance.licenseServerUrl,
      'license_cipher_path': instance.licenseCipherPath,
      'license_cert_url': instance.licenseCertUrl,
      'token': instance.token,
      'downloadStatus': _$DownloadStatusEnumMap[instance.downloadStatus],
    };

const _$DownloadStatusEnumMap = {
  DownloadStatus.running: 'running',
  DownloadStatus.pending: 'pending',
  DownloadStatus.pause: 'pause',
  DownloadStatus.failed: 'failed',
  DownloadStatus.success: 'success',
};
