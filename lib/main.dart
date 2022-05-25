import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita_test/bloc/issue_bloc.dart';
import 'package:sejuta_cita_test/repository/issue-repository.dart';
import 'package:sejuta_cita_test/screens/homepage/home-screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.amber,
      ),
      home: BlocProvider<IssueBloc>(
        create: (context) => IssueBloc(IssueRepo(), "flutter")..add(IssueFetchedEvent()),
        child: HomeScreen(),
      ),
    );
  }
}
