import 'package:demo_of_ddd/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:demo_of_ddd/injection.dart';
import 'package:demo_of_ddd/presentation/sign_in/widget/sign_in_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('SignIn'),
        ),
        body: BlocProvider(
          create: (context) => getIt<SignInFormBloc>(),
          child: SignInForm(),
        ));
  }
}
