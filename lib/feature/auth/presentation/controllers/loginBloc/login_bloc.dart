// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:nirals/feature/auth/provider/userprovider.dart';
// import '../../../data/failure.dart';
// import '../../../domain/repositories/auth_repository.dart';
// import '../../../provider/authentication.dart';
// import 'login_event.dart';
// import 'login_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final UserService userService;
//   final AuthService authService;
//   final AuthRepository repository;

//   LoginBloc(this.repository, this.authService, this.userService) : super(LoginInitial()) {
//     on<LoginButtonPressed>((event, emit) async {
//       final connectivity = await Connectivity().checkConnectivity();
//       if (connectivity == ConnectivityResult.none) {
//         emit(LoginFailure(error: 'No Internet Connection'));
//         return;
//       }

//       emit(LoginLoading());

//       final result = await repository.login(event.userId, event.password);

//       await result.fold(
//         (Failure failure) async => emit(LoginFailure(error: failure.message)),

//         (user) async {
//           logger.f("User model Data : $user");
//           logger.w(user.token);
//           await authService.saveToken(user.token);
//           await userService.saveUser(user);
//           emit(LoginSuccess(message: user.message));
//         },
//       );
//     });
//   }
// }
