import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sejuta_cita_test/components/radio-option.dart';

import '../screens/with-index-screen.dart';

class CustomBar extends StatelessWidget with PreferredSizeWidget{
  final VoidCallback lazyPress;
  final VoidCallback indexPress;
  const CustomBar({Key? key, required this.indexPress, required this.lazyPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RadioOption(),
          Row(
            children: [
              TextButton(
                  onPressed: lazyPress,
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  child: const Text("Lazy Loading")),
              const SizedBox(width: 10,),
              TextButton(
                  onPressed: indexPress,
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  child: const Text("With Index")),
            ],
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(100);
}