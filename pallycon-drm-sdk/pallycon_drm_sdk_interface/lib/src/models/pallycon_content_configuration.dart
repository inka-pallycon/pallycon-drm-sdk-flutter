import '../enums/drm_type.dart';

class PallyConContentConfiguration {
  final String contentUrl;
  final String contentId;
  final DRMType? drmType;
  final String? token;
  final String? customData;
  final String? contentCookie;
  final Map<String, String>? contentHttpHeaders;
  final String? licenseCookie;
  final Map<String, String>? licenseHttpHeaders;
  final String licenseUrl;
  final String certificateUrl;
  final String? licenseCipherTablePath;

  PallyConContentConfiguration(
      this.contentUrl,
      this.contentId,
      {this.drmType,
        this.token,
        this.customData,
        this.contentCookie,
        this.contentHttpHeaders,
        this.licenseCookie,
        this.licenseHttpHeaders,
        this.licenseUrl = "https://license-global.pallycon.com/ri/licenseManager.do",
        this.certificateUrl = "",
        this.licenseCipherTablePath
      });

}
