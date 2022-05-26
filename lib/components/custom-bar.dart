import 'dart:developer';

import 'package:flutter/material.dart';

import '../screens/with-index-screen.dart';

class CustomBar extends StatelessWidget with PreferredSizeWidget {
  final VoidCallback lazyPress;
  final VoidCallback indexPress;
  const CustomBar({Key? key, required this.indexPress, required this.lazyPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 50,
      child: Column(
        children: [
          Row(
            children: const [
              Text("Opsi user issues repo"), // TODO pake tab?
            ],
          ),
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
