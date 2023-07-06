import 'package:demo_of_ddd/injection.dart';
import 'package:demo_of_ddd/presentation/core/app_widget.dart';
import 'package:demo_of_ddd/presentation/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

void main() async {
  configureInjection(Environment.prod);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(AppWidget());
}
