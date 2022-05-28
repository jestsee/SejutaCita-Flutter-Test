import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita_test/bloc/app_bloc.dart';
import 'package:sejuta_cita_test/constants.dart';
import 'package:sejuta_cita_test/repository/repository.dart';
import 'package:sejuta_cita_test/screens/home-screen.dart';
import 'package:sejuta_cita_test/screens/lazy-screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AppBloc(RepositoryRepo(), "doraemon")..add(NewQueryEvent("doraemon")),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
