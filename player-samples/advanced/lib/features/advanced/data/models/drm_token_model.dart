class DrmTokenModel {
  String token;

  DrmTokenModel(
      {required this.token});

  factory DrmTokenModel.fromJson(Map<String, dynamic> json) =>
      DrmTokenModel(
          token: json['token']
      );
}
