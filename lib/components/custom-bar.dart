import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sejuta_cita_test/components/radio-option.dart';
import 'package:sejuta_cita_test/constants.dart';

import '../screens/with-index-screen.dart';

class CustomBar extends StatelessWidget with PreferredSizeWidget {
  final VoidCallback lazyPress;
  final VoidCallback indexPress;

  const CustomBar({Key? key, required this.indexPress, required this.lazyPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: kBlueLightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RadioOption(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: lazyPress,
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),)),
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  child: const Text(
                    "Lazy Loading",
                    style: TextStyle(color: kBackgroundColor),
                  )),
              const SizedBox(
                width: 10,
              ),
              TextButton(
                  onPressed: indexPress,
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),)),
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  child: const Text(
                    "With Index",
                    style: TextStyle(color: kBackgroundColor),
                  )),
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
