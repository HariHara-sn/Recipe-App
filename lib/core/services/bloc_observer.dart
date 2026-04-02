import 'package:flutter_bloc/flutter_bloc.dart';

import '../logging/logger.dart';

/// Logs every BLoC/Cubit lifecycle event to the console. 
/// Registered only in debug mode via assert() in main.dart.
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    logger.i('🟢 [BLoC] Created  → ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.d('📩 [BLoC] Event    → ${bloc.runtimeType} received ${event.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.d('🔄 [BLoC] Change   → ${bloc.runtimeType}\n'
        '         current: ${change.currentState.runtimeType}\n'
        '         next:    ${change.nextState.runtimeType}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.d('➡️  [BLoC] Transition → ${bloc.runtimeType} '
        '| ${transition.event.runtimeType} '
        '→ ${transition.nextState.runtimeType}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e('🔴 [BLoC] Error    → ${bloc.runtimeType}: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    logger.w('🔴 [BLoC] Closed   → ${bloc.runtimeType}');
  }
}
