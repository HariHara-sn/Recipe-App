// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// import '../../../../../main.dart';
// import '../../../data/failure.dart';
// import '../../../domain/repositories/auth_repository.dart';

// part 'signup_event.dart';
// part 'signup_state.dart';

// class SignUpBloc extends Bloc<SignupButtonPressed, SignupState> {
//   final AuthRepository repository;
//   SignUpBloc(this.repository) : super(SignupInitial()) {
//     on<SignupButtonPressed>((event, emit) async {
//       emit(SignupLoading());
//       final result = await repository.signups(
//         event.userId,
//         event.username,
//         event.password,
//       );

//       await result.fold(
//         (Failure failure) async => emit(SignupFailure(error: failure.message)),

//         (successMessage) async {
//           logger.d(successMessage);
//           emit(SignupSuccess(message: successMessage));
//         },
//       );
//     });
//   }
// }
