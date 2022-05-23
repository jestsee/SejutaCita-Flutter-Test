import "package:flutter/material.dart";
import 'package:sejuta_cita_test/screens/home/home-body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: HomeBody(),
    );
  }
}
