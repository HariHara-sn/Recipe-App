[This is how the data is flown in structured way]
Imagine the user is first time opening the app
- 
    - In main.dart, `create: (_) => AuthBloc(authRepository)..add(AppStarted()),` This creates the AuthBloc and adds the AppStarted event to it. - [main.dart]
    - The AppStarted event calls the _onAppStarted function  - [auth_bloc.dart]
    - Then _authRepository.getAuthState() calls - [auth_bloc.dart]
    - Then the getAuthState() function calls (only abstract class)- [domain/repositories/auth_repository.dart]
    - Then the getAuthState() function calls (implementation) - [auth/repositories/auth_repository_impl.dart]
    - Then above getAuthState() function Implementation written in FirebaseAuthDataSource - [firebase_auth_datasource.dart]
    - In [firebase_auth_datasource.dart] firebase checks in cloudDatabase and it returns Null because user is opening the app for the first time. So it returns null to [auth_repository_impl.dart]
    - Then it returns null back to [auth_bloc.dart]
    - Then in [auth_bloc.dart] it checks if user is null or not. If user is null then it emits AuthUnauthenticated state. So it emits AuthUnauthenticated to the UI.
    - Then in UI it checks if state is AuthUnauthenticated then it shows the LoginScreen.