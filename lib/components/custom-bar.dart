import 'dart:developer';

import 'package:flutter/material.dart';

class CustomBar extends StatelessWidget with PreferredSizeWidget {
  const CustomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 50,
      child: Column(
        children: [
          Row(
            children: [
              Text("Opsi user issues repo"),
            ],
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    log("lazy pressed");
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  child: Text("Lazy Loading")),
              SizedBox(width: 10,),
              TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  child: Text("With Index")),
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
