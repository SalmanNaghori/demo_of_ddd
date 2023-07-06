import 'package:bloc/bloc.dart';
import 'package:demo_of_ddd/domain/auth/i_auth_facade.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthFacade _authFacade;

  AuthBloc(@Named('FirebaseAuthFacade') this._authFacade)
      : super(AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      emit(
        await event.map(authCheckRequested: (e) async {
          final userOption = await _authFacade.getSignedInUser();
          return userOption.fold(
            () => const AuthState.unauthenticated(),
            (_) => const AuthState.authenticated(),
          );
        }, signedOut: (e) async {
          await _authFacade.signOut();
          return const AuthState.unauthenticated();
        }),
      );
    });
  }
}
