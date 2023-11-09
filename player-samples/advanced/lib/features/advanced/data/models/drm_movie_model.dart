import 'package:advanced/features/advanced/domain/entities/download_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:advanced/features/advanced/domain/entities/drm_movie.dart';

part 'drm_movie_model.g.dart';

@JsonSerializable()
class DrmMovieModel extends DrmMovie {
  DrmMovieModel(
      this.url,
      this.contentType,
      this.streamFormat,
      this.mediaType,
      this.title,
      this.contentId,
      this.videoCodec,
      this.videoProfile,
      this.maximumResolution,
      this.frameRate,
      this.containerFormat,
      this.audioCodec,
      this.audioLanguage,
      this.licenseServerUrl,
      this.licenseCipherPath,
      this.token,
      this.downloadStatus)
      : super(
            url: url,
            contentType: contentType,
            streamFormat: streamFormat,
            mediaType: mediaType,
            title: title,
            contentId: contentId,
            videoCodec: videoCodec,
            videoProfile: videoProfile,
            maximumResolution: maximumResolution,
            frameRate: frameRate,
            containerFormat: containerFormat,
            audioCodec: audioCodec,
            audioLanguage: audioLanguage,
            licenseServerUrl: licenseServerUrl,
            licenseCipherPath: licenseCipherPath,
            token: token,
            downloadStatus: downloadStatus );

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'content_type')
  String contentType;

  @JsonKey(name: 'stream_format')
  String streamFormat;

  @JsonKey(name: 'media_type')
  String mediaType;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'content_id')
  String contentId;

  @JsonKey(name: 'video_codec')
  String videoCodec;

  @JsonKey(name: 'video_profile')
  String videoProfile;

  @JsonKey(name: 'maximum_resolution')
  String maximumResolution;

  @JsonKey(name: 'frame_rate')
  String frameRate;

  @JsonKey(name: 'container_format')
  String containerFormat;

  @JsonKey(name: 'audio_codec')
  String audioCodec;

  @JsonKey(name: 'audio_language')
  String audioLanguage;

  @JsonKey(name: 'license_server_url')
  String? licenseServerUrl;

  @JsonKey(name: 'license_cipher_path')
  String? licenseCipherPath;

  String? token;

  DownloadStatus? downloadStatus;

  factory DrmMovieModel.fromJson(Map<String, dynamic> json) =>
      _$DrmMovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$DrmMovieModelToJson(this);
}
