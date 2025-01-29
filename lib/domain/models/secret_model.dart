class SecretModel {
  String apiKey;
  String accessToken;
  SecretModel({this.apiKey = "", this.accessToken = ""});

  void fromJson(Map<String, dynamic> json) {
    apiKey = json['api_key'];
    accessToken = json["access_token"];
  }
}
