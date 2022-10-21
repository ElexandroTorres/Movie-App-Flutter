class TokenRequest {
  bool? success = false;
  String? expiresAt;
  String? requestToken;

  TokenRequest({this.success, this.expiresAt, this.requestToken});

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'expires_at': expiresAt,
      'request_token': requestToken,
    };
  }

  factory TokenRequest.fromMap(Map<String, dynamic> map) {
    return TokenRequest(
      success: map['success'],
      expiresAt: map['expires_at'],
      requestToken: map['request_token'],
    );
  }

  TokenRequest.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    expiresAt = json['expires_at'];
    requestToken = json['request_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    data['expires_at'] = expiresAt;
    data['request_token'] = requestToken;
    return data;
  }

  @override
  String toString() {
    return '$success $expiresAt $requestToken';
  }
}
