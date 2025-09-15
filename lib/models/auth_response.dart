class AuthResponse {
  final bool success;
  final String? message;
  final Map<String, dynamic>? data;

  AuthResponse({required this.success, this.message, this.data});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'],
    );
  }
}
