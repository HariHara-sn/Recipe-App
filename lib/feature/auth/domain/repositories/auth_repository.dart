import 'package:dartz/dartz.dart';
import '../../data/api.dart';
import '../../data/failure.dart';
import '../models/auth_model.dart';

class AuthRepository {
  final AuthApi _api;  //creating an obj for AuthApi class

  AuthRepository(this._api);

  Future<Either<Failure, LoginResponse>> login(String userId, String password) {
    return _api.login(userId, password);
  }
    Future<Either<Failure, String>> signups(String userId,String username, String password) {
    return _api.signup(userId, username,password);
  }
}










// import 'package:learnpro/feature/auth/data/api.dart'; // Api data
// import 'package:learnpro/feature/auth/domain/models/auth_model.dart'; // Models

// class AuthRepository {
//   final AuthAPICalls _api = AuthAPICalls();

//   Future<GetOtpResponse> GetOTP(String email) async {
//     try {
//       final responseJson = await _api.GetOTP(email);

//       return GetOtpResponse.fromJson(responseJson); // Parse JSON to model
//     } catch (e) {
//       rethrow; // Re-throw the error to be handled by the controller
//     }
//   }

//   Future<OtpVerificationResponse> authenticateOTP(String email, int otp) async {
//     try {
//       final responseJson = await _api.authenticateOTP(email, otp);

//       return OtpVerificationResponse.fromJson(
//           responseJson); // Parse JSON to model
//     } catch (e) {
//       rethrow; // Re-throw the error to be handled by the controller
//     }
//   }

//   Future<GoogleOAuthVerificationResponse> GoogleSignIN(String idToken) async {
//     try {
//       final responseJson = await _api.GoogleSignIN(idToken);

//       return GoogleOAuthVerificationResponse.fromJson(
//           responseJson); // Parse JSON to model
//     } catch (e) {
//       rethrow; // Re-throw the error to be handled by the controller
//     }
//   }

//   Future<AppleOAuthVerificationResponse> AppleSignIN(String idToken) async {
//     try {
//       final responseJson = await _api.AppleSignIN(idToken);

//       return AppleOAuthVerificationResponse.fromJson(
//           responseJson); // Parse JSON to model
//     } catch (e) {
//       rethrow; // Re-throw the error to be handled by the controller
//     }
//   }
// }
