class Failure {
  final String message;
  Failure(this.message);
}


class ApiResponse {
  final String message;

  ApiResponse({required this.message});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'] ?? 'Something went wrong',
    );
  }
}
 // instead use the exception class to handle errors














//  class FailureResponse {
//   final String message;

//   FailureResponse({required this.message});

//   factory FailureResponse.fromJson(Map<String, dynamic> json) {
//     return FailureResponse(
//       message: json['message'] ?? 'Something went wrong',
//     );
//   }
// }

//the above is for you to understand the error response from the server