import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dartz/dartz.dart';
import 'package:demo_of_ddd/domain/auth/auth_faild.dart';
import 'package:demo_of_ddd/domain/auth/i_auth_facade.dart';
import 'package:demo_of_ddd/domain/auth/value_objects.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

part 'sign_in_form_bloc.freezed.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial()) {
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(
        emailAddress: EmailAddress(event.emailStr),
        authFailureOrSuccessOption: none(),
      ));
    });
    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(
        password: Password(event.passwordStr),
        authFailureOrSuccessOption: none(),
      ));
    });
    on<RegisterWithEmailAndPasswordPressed>((event, emit) async {
      Either<AuthFailure, Unit>? failureOrSuccess;

      final isEmailValid = state.emailAddress.isValid();
      final isPasswordValid = state.password.isValid();

      if (isEmailValid && isPasswordValid) {
        emit(state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        ));
        failureOrSuccess = await _authFacade.signInWithEmailAndPassword(
          emailAddress: state.emailAddress,
          password: state.password,
        );
        emit(state.copyWith(
          isSubmitting: false,
          showErrorMessages: true,
          authFailureOrSuccessOption: optionOf(failureOrSuccess),
        ));
      }

      emit(state.copyWith(
        isSubmitting: false,
        showErrorMessages: true,
        authFailureOrSuccessOption: optionOf(failureOrSuccess),
      ));
    });
    on<SignInWithEmailAndPasswordPressed>((event, emit) async {
      await _performActionOnAuthFacadeWithEmailAndPasswor(
        _authFacade.signInWithEmailAndPassword,
      );
    });
    on<SignInWithGooglePressed>((event, emit) async {
      emit(state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      ));
      final failureOrSuccess = await _authFacade.signInWithGoogle();
      emit(state.copyWith(
        isSubmitting: false,
        authFailureOrSuccessOption: some(failureOrSuccess),
      ));
    });
  }

  // Stream<SignInFormState> mapEventToState(SignInFormEvent event) async* {
  //   yield* event.when(
  //     emailChanged: (String emailStr) async* {
  //       yield state.copyWith(
  //         emailAddress: EmailAddress(emailStr),
  //         authFailureOrSuccessOption: none(),
  //       );
  //     },
  //     passwordChanged: (String passwordStr) async* {
  //       yield state.copyWith(
  //         password: Password(passwordStr),
  //         authFailureOrSuccessOption: none(),
  //       );
  //     },
  //     registerWithEmailAndPasswordPressed: () async* {
  //       yield* _performActionOnAuthFacadeWithEmailAndPasswor(
  //         _authFacade.registerWithEmailAndPassword,
  //       );
  //     },
  //     signInWithEmailAndPasswordPressed: () async* {
  //       yield* _performActionOnAuthFacadeWithEmailAndPasswor(
  //         _authFacade.signInWithEmailAndPassword,
  //       );
  //     },
  //     signInWithGooglePressed: () async* {
  //       yield state.copyWith(
  //         isSubmitting: true,
  //         authFailureOrSuccessOption: none(),
  //       );
  //       final failureOrSuccess = await _authFacade.signInWithGoogle();
  //       yield state.copyWith(
  //         isSubmitting: false,
  //         authFailureOrSuccessOption: some(failureOrSuccess),
  //       );
  //     },
  //   );
  // }

  Stream<SignInFormState> _performActionOnAuthFacadeWithEmailAndPasswor(
    Future<Either<AuthFailure, Unit>> Function({
      required EmailAddress emailAddress,
      required Password password,
    }) forwardedCall,
  ) async* {}
}
