import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>((event, emit) async {
      try {
        final email = event.email;
        final password = event.password;

        final emailRegex = RegExp(r'^[a-zA-Z0-9._%-]+@[a-z]+\.[a-z]{2,3}$');
        if (!emailRegex.hasMatch(email)) {
          return emit(AuthFailure("Please enter a valid email address"));
        }

        if (password.length < 6) {
          return emit(
            AuthFailure("Password cannot be less than 6 characters! "),
          );
        }

        await Future.delayed(const Duration(seconds: 1), () {
          return emit(AuthSuccess(uid: '$email-$password'));
        });
      } catch (e) {
        return emit(AuthFailure(e.toString()));
      }
    });
  }
}
