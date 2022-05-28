import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sejuta_cita_test/components/custom-bottom-bar.dart';
import 'package:sejuta_cita_test/components/radio-option.dart';
import 'package:sejuta_cita_test/components/search-bar.dart';
import 'package:sejuta_cita_test/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .8,
            decoration: const BoxDecoration(
                color: kBlueLightColor,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(120))),
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: Text(greeting(),
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                            fontWeight: FontWeight.w900, fontSize: 72)),
                  ),
                  const SizedBox(height: 16),
                  const SearchBar(homePage: true,),
                  const SizedBox(height: 8),
                  const RadioOption(homePage: true,),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}

String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning!';
  }
  if (hour < 17) {
    return 'Good Afternoon';
  }
  return 'Good Evening';
}