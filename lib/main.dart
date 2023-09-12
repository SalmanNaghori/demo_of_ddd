import 'package:demo_of_ddd/injection.dart';
import 'package:demo_of_ddd/presentation/core/app_widget.dart';
import 'package:demo_of_ddd/presentation/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

void main() async {
  print('-- main');

  WidgetsFlutterBinding.ensureInitialized();
  print('-- WidgetsFlutterBinding.ensureInitialized');

  await Firebase.initializeApp();
  print('-- main: Firebase.initializeApp');
  runApp(AppWidget());
}
