class RequestToken {
  final String requestToken;
  final String expiresAt;

  RequestToken({
    required this.requestToken,
    required this.expiresAt,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map();
    data['request_token'] = this.requestToken;
    data["expires_at"] = this.expiresAt;
    return data;
  }

  factory RequestToken.fromJson(Map<String, dynamic> json) {
    return RequestToken(
      requestToken: json['request_token'],
      expiresAt: json['expires_at'],
    );
  }
}
