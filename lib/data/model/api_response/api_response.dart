class ApiResponse<T> {
  final bool error;
  final String message;
  final T? data;

  ApiResponse({required this.error, required this.message, this.data});

  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json)? fromJsonT,
      ) =>
      ApiResponse(
        error: json['error'] as bool,
        message: json['message'] as String,
        data: json['data'] != null ? fromJsonT!(json['data']) : null,
      );
}
