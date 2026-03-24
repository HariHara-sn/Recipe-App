// import 'package:dartz/dartz.dart';
// import 'package:nirals/feature/auth/domain/models/auth_model.dart';
// import '../../../main.dart';
// import 'failure.dart';
// import 'package:dio/dio.dart';

// import 'urls.dart';

// class AuthApi {
//   final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: AuthUrl.baseUrl,
//       headers: {'Content-Type': 'application/json'},
//       validateStatus: (status) {
//         return status! <= 500;
//       },
//     ),
//   );
//   //LOGIN
//   Future<Either<Failure, LoginResponse>> login(String userId, String password) async {
//     try {
//       final response = await _dio.get(
//         AuthUrl.LOGIN, //end point
//         queryParameters: {"userId": userId, "password": password},
//       );

//       final data = response.data;
//       logger.d(data);

//       if (response.statusCode == 200 && data['token'] != null) {
//         return Right(LoginResponse.fromJson(data));
//       } else {
//         final errorRes = ApiResponse.fromJson(data);
//         return Left(Failure(errorRes.message));
//       }
//     } catch (e) {
//       logger.e("Login error: $e");
//       return Left(Failure('Something went wrong: ${e.toString()}'));
//     }
//   }

//   //SIGNUP
//   Future<Either<Failure, String>> signup(
//     String userId,
//     String username,
//     String password,
//   ) async {
//     try {
//       final response = await _dio.post(
//         AuthUrl.SIGNUP, //end point
//         data: {"userId": userId, "username": username, "password": password},
//       );

//       final data = response.data;
//       logger.d(data);

//       if (response.statusCode == 201) {
//         final successRes = ApiResponse.fromJson(data);
//         return Right(successRes.message);
//       } else {
//         final errorRes = ApiResponse.fromJson(data);
//         return Left(Failure(errorRes.message));
//       }
//     } catch (e) {
//       logger.e("Signup error: $e");
//       return Left(Failure('Something went wrong: ${e.toString()}'));
//     }
//   }
// }
















// // import 'dart:convert';
// // import 'dart:async';
// // import 'package:flutter/foundation.dart';
// // // import 'package:http/http.dart' as http;
// // class AuthAPICalls {
// //   String _getDefaultErrorMessage(int statusCode) {
// //     switch (statusCode) {
// //       case 400:
// //         return 'Invalid request. Please check your input.';
// //       case 401:
// //         return 'Invalid credentials. Please try again.';
// //       case 403:
// //         return 'You do not have permission to access this resource.';
// //       case 404:
// //         return 'The requested resource was not found.';
// //       case 500:
// //         return 'An error occurred on the server. Please try again later.';
// //       case 503:
// //         return 'Service is temporarily unavailable. Please try again later.';
// //       default:
// //         return 'An unexpected error occurred. Please try again.';
// //     }
// //   }

// //   Map<String, dynamic> _handleResponse(http.Response response) {
// //     final responseBody = jsonDecode(response.body);

// //     if (response.statusCode == 200) {
// //       return responseBody;
// //     }

// //     throw HttpException(
// //       response.statusCode,
// //       responseBody['message'] ?? _getDefaultErrorMessage(response.statusCode),
// //     );
// //   }

// //   Future<Map<String, dynamic>> GetOTP(String email) async {
// //     final url = AuthUrl.GetOTP;

// //     try {
// //       final response = await http
// //           .post(
// //         Uri.parse(url),
// //         headers: {'Content-Type': 'application/json'},
// //         body: jsonEncode({
// //           'email_id': email,
// //         }),
// //       )
// //           .timeout(const Duration(seconds: 30), onTimeout: () {
// //         throw TimeoutException(408, 'Request timed out. Please try again.');
// //       });
// //       // Print raw response details
// //       debugPrint('Response Status Code: ${response.statusCode}');
// //       debugPrint('Response Body: ${response.body}');

// //       // Parse and print the response data
// //       final responseData = _handleResponse(response);
// //       debugPrint('Parsed Response Data: $responseData');
// //       return _handleResponse(response);
// //     } on http.ClientException {
// //       throw HttpException(503, 'Please check your internet connection.');
// //     } catch (e) {
// //       debugPrint("Error: $e");
// //       throw HttpException(500, '$e');
// //     }
// //   }

// //   Future<Map<String, dynamic>> authenticateOTP(String email, int otp) async {
// //     final url = AuthUrl.AuthenticateOTP;

// //     try {
// //       final response = await http
// //           .post(
// //         Uri.parse(url),
// //         headers: {'Content-Type': 'application/json'},
// //         body: jsonEncode({
// //           'email_id': email,
// //           'otp': otp,
// //         }),
// //       )
// //           .timeout(const Duration(seconds: 10), onTimeout: () {
// //         throw TimeoutException(408, 'Request timed out. Please try again.');
// //       });
// //       return _handleResponse(response);
// //     } on http.ClientException {
// //       throw HttpException(503, 'Please check your internet connection.');
// //     } catch (e) {
// //       throw HttpException(500, '$e');
// //     }
// //   }

// //   Future<Map<String, dynamic>> GoogleSignIN(String idToken) async {
// //     final url = AuthUrl.GoogleSignIN;

// //     try {
// //       final response = await http
// //           .post(
// //         Uri.parse(url),
// //         headers: {'Content-Type': 'application/json'},
// //         body: jsonEncode({
// //           'idToken': idToken,
// //         }),
// //       )
// //           .timeout(const Duration(seconds: 10), onTimeout: () {
// //         throw TimeoutException(408, 'Request timed out. Please try again.');
// //       });
// //       return _handleResponse(response);
// //     } on http.ClientException {
// //       throw HttpException(503, 'Please check your internet connection.');
// //     } catch (e) {
// //       throw HttpException(500, '$e');
// //     }
// //   }

// //   Future<Map<String, dynamic>> AppleSignIN(String idToken) async {
// //     final url = AuthUrl.AppleSignIN;

// //     try {
// //       final response = await http
// //           .post(
// //         Uri.parse(url),
// //         headers: {'Content-Type': 'application/json'},
// //         body: jsonEncode({
// //           'idToken': idToken,
// //         }),
// //       )
// //           .timeout(const Duration(seconds: 10), onTimeout: () {
// //         throw TimeoutException(408, 'Request timed out. Please try again.');
// //       });
// //       return _handleResponse(response);
// //     } on http.ClientException {
// //       throw HttpException(503, 'Please check your internet connection.');
// //     } catch (e) {
// //       throw HttpException(500, '$e');
// //     }
// //   }
// // }


