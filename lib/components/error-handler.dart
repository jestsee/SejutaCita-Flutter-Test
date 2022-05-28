import 'dart:ui';

import 'package:flutter/material.dart';

class ErrorHandler extends StatelessWidget {
  final String text;

  const ErrorHandler({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.warning_amber_rounded,
          color: Colors.black,
          size: 260,
        ),
        SizedBox(
          height: size.height * .01,
        ),
        const Text(
          "Oops!",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: size.width * .7,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
