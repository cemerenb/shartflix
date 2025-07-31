class ApiResponse {
  final int code;
  final String message;
  final Map<String, dynamic> data;

  ApiResponse({required this.code, required this.message, required this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['response']['code'] ?? 0,
      message: json['response']['message'] ?? '',
      data: Map<String, dynamic>.from(json['data'] ?? {}),
    );
  }
}
