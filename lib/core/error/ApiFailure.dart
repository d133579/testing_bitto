class ApiFailure {
  final int statusCode;
  final String responseBody;

  ApiFailure({required this.statusCode, required this.responseBody});

  @override
  String toString() =>
      'ApiFailure(statusCode: $statusCode, responseBody: $responseBody)';
}
